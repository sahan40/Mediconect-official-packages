import 'dart:convert';

import 'package:http/http.dart' as http;

class FhirHttpException implements Exception {
  final int statusCode;
  final String message;

  const FhirHttpException({required this.statusCode, required this.message});

  @override
  String toString() => 'FhirHttpException($statusCode): $message';
}

class FhirHttpClient {
  final http.Client _client;
  final String _baseUrl;
  final Future<String?> Function()? _getAccessToken;

  FhirHttpClient({
    required String baseUrl,
    http.Client? client,
    Future<String?> Function()? getAccessToken,
  }) : _baseUrl = baseUrl.replaceAll(RegExp(r'/+$'), ''),
       _client = client ?? http.Client(),
       _getAccessToken = getAccessToken;

  Uri _buildUri(String path, [Map<String, String>? query]) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$_baseUrl$normalizedPath');
    if (query == null || query.isEmpty) return uri;
    return uri.replace(queryParameters: query);
  }

  Future<Map<String, String>> _headers() async {
    final headers = <String, String>{
      'Accept': 'application/fhir+json',
      'Content-Type': 'application/fhir+json',
    };

    final token = await _getAccessToken?.call();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? query,
  }) async {
    final response = await _client.get(
      _buildUri(path, query),
      headers: await _headers(),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final response = await _client.post(
      _buildUri(path),
      headers: await _headers(),
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> put(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final response = await _client.put(
      _buildUri(path),
      headers: await _headers(),
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    final body = response.body.isEmpty ? '{}' : response.body;
    final decoded = jsonDecode(body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw FhirHttpException(
        statusCode: response.statusCode,
        message:
            decoded is Map<String, dynamic>
                ? (decoded['issue']?.toString() ??
                    response.reasonPhrase ??
                    'HTTP error')
                : (response.reasonPhrase ?? 'HTTP error'),
      );
    }

    if (decoded is! Map<String, dynamic>) {
      throw const FhirHttpException(
        statusCode: 500,
        message: 'FHIR response is not a JSON object.',
      );
    }

    return decoded;
  }

  void dispose() {
    _client.close();
  }
}
