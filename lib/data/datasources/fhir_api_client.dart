import 'dart:convert';

import 'package:http/http.dart' as http;

class FhirApiClient {
  final String baseUrl;
  final http.Client _client;

  FhirApiClient({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  Future<Map<String, dynamic>> getJson(String resourcePath) async {
    final uri = Uri.parse('$baseUrl$resourcePath');
    final response = await _client.get(
      uri,
      headers: const {
        'Accept': 'application/fhir+json',
        'Content-Type': 'application/fhir+json',
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('FHIR request failed (${response.statusCode}) for $uri');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Unexpected FHIR response format for $uri');
    }
    return decoded;
  }

  void dispose() {
    _client.close();
  }
}
