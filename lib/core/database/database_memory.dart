import 'dart:io';

import 'package:gestor_horas/core/database/database_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseMemory implements DatabaseProvider {
  Database? _database;

  DatabaseMemory();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    await _populateDB(_database!);
    return _database!;
  }

  Future<void> closeDatabase() async {
    await _database!.close();
    _database = null;
  }

  Future<Database> _initDB() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    return await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(version: 1, onCreate: _createDB, onUpgrade: _updateDB),
    );
  }

  Future _createDB(Database database, int version) async {
    await database.transaction((transaction) async {
      await transaction.execute('''
        CREATE TABLE IF NOT EXISTS employees (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT NOT NULL,
          hours_in_contract INTEGER NOT NULL DEFAULT 0
        )
        ''');

      await transaction.execute('''
        CREATE TABLE IF NOT EXISTS time_trackings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_employee INTEGER NOT NULL,
          start_time DATETIME,
          finish_time DATETIME,
          FOREIGN KEY(id_employee) REFERENCES employees(id)
        ) 
        ''');

      await transaction.execute('''
        CREATE TABLE IF NOT EXISTS schedules (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          start_time DATETIME NOT NULL,
          finish_time DATETIME NOT NULL,
          start_second_time DATETIME,
          finish_second_time DATETIME,
          weekdays STRING NOT NULL,
          color STRING NOT NULL
        )''');

      await transaction.execute('''
        CREATE TABLE IF NOT EXISTS employee_schedules (
          id_employee INTEGER NOT NULL,
          id_schedule INTEGER NOT NULL,
          assigned_week STRING,
          PRIMARY KEY (id_employee, id_schedule, assigned_week),
          FOREIGN KEY(id_employee) REFERENCES employees(id),
          FOREIGN KEY(id_schedule) REFERENCES schedules(id)
        )
        ''');
    });
  }

  Future _updateDB(Database database, int version, int newVersion) async {}

  Future<void> _populateDB(Database db) async {
    File file = File('lib/assets/sql/insert_data_test.sql');
    List<String> lines = await file.readAsLines();
    List<String> sentences = List.empty(growable: true);
    String test = '';

    await db.transaction((transaction) async {
      for (final line in lines) {
        final sql = line.trim();

        if (sql.isEmpty || sql.startsWith('--')) continue;

        test += ' $line';
        if (line.contains(';')) {
          sentences.add(test);
          test = '';
        }
      }

      for (final sentence in sentences) {
        await transaction.execute(sentence);
      }
    });
  }
}
