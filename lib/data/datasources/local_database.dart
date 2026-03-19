import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  Database? _database;

  Future<Database?> ensureInitialized() async {
    if (_database != null) return _database;

    // sqflite is not supported on web; keep initialization no-op there.
    if (kIsWeb) return null;

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = '${documentsDirectory.path}/mediconnect.db';

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS app_kv (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL
          )
        ''');
      },
    );

    return _database;
  }

  Future<void> putValue({required String key, required String value}) async {
    final db = await ensureInitialized();
    if (db == null) return;

    await db.insert('app_kv', {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getValue(String key) async {
    final db = await ensureInitialized();
    if (db == null) return null;

    final rows = await db.query(
      'app_kv',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return rows.first['value'] as String?;
  }

  Future<void> clearValue(String key) async {
    final db = await ensureInitialized();
    if (db == null) return;

    await db.delete('app_kv', where: 'key = ?', whereArgs: [key]);
  }
}
