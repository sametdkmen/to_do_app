import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Copies the bundled SQLite database to the device on first launch and
/// opens it.
class DatabaseHelper {
  DatabaseHelper._();

  static const String databaseName = "todo_db.sqlite";
  static const String bundledDatabasePath = "assets/database/$databaseName";

  static Future<Database> open() async {
    final String databasePath = join(await getDatabasesPath(), databaseName);

    if (!await databaseExists(databasePath)) {
      final ByteData data = await rootBundle.load(bundledDatabasePath);
      final List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(databasePath);
  }
}
