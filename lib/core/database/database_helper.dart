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
      options: OpenDatabaseOptions(version: 4, onCreate: _createDB, onUpgrade: _updateDB),
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS employees (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS employee_time_tracking (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      employee_id INTEGER NOT NULL,
      start_time DATETIME,
      finish_time DATETIME,
      registered_date DATE,
      difference INTEGER DEFAULT 0,
      FOREIGN KEY(employee_id) REFERENCES employees(id)
    ) 
    ''');
  }

  Future _updateDB(Database db, int version, int newVersion) async {
    await db.execute('''
    ALTER TABLE employees ADD COLUMN "has_contract"	BOOLEAN NOT NULL DEFAULT 0
    ''');

    await db.execute('''
    ALTER TABLE employees ADD COLUMN "hours_in_contract" INTEGER NOT NULL DEFAULT 0
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS schedules (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      start_time DATETIME NOT NULL,
      finish_time DATETIME NOT NULL,
      week INTEGER
    )''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS employee_schedules (
      id_employee INTEGER NOT NULL,
      id_schedule INTEGER NOT NULL,
      PRIMARY KEY (id_employee, id_schedule),
      FOREIGN KEY(id_employee) REFERENCES employees(id),
      FOREIGN KEY(id_schedule) REFERENCES schedules(id)
    )
    ''');
  }

  // https://medium.com/@jamshaidaslam/step-by-step-sqlite-offline-database-setup-in-flutter-with-jamshaid-malik-b81c2c98a8cf
  // https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
}
