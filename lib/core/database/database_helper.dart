import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('local_database.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final directory = await getDatabasesPath();
    final path = join(directory, fileName);

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(version: 1, onCreate: _createDB, onUpgrade: _updateDB),
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS employees (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL,
      hours_in_contract INTEGER NOT NULL DEFAULT 0
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS time_trackings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_employee INTEGER NOT NULL,
      start_time DATETIME,
      finish_time DATETIME,
      FOREIGN KEY(id_employee) REFERENCES employees(id)
    ) 
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS schedules (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      start_time DATETIME NOT NULL,
      finish_time DATETIME NOT NULL,
      start_second_time DATETIME,
      finish_second_time DATETIME,
      weekdays STRING NOT NULL,
      color STRING NOT NULL
    )''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS employee_schedules (
      id_employee INTEGER NOT NULL,
      id_schedule INTEGER NOT NULL,
      assigned_week STRING,
      PRIMARY KEY (id_employee, id_schedule, assigned_week),
      FOREIGN KEY(id_employee) REFERENCES employees(id),
      FOREIGN KEY(id_schedule) REFERENCES schedules(id)
    )
    ''');
  }

  Future _updateDB(Database db, int version, int newVersion) async {

  }

  // https://medium.com/@jamshaidaslam/step-by-step-sqlite-offline-database-setup-in-flutter-with-jamshaid-malik-b81c2c98a8cf
  // https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
}
