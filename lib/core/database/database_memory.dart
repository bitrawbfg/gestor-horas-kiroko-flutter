import 'package:gestor_horas/core/database/database_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseMemory implements DatabaseProvider {
  Database? _database;

  DatabaseMemory();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
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

  Future _updateDB(Database db, int version, int newVersion) async {}
}
