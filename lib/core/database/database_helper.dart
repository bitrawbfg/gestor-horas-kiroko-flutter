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
      options: OpenDatabaseOptions(version: 1, onCreate: _createDB),
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

  // https://medium.com/@jamshaidaslam/step-by-step-sqlite-offline-database-setup-in-flutter-with-jamshaid-malik-b81c2c98a8cf
  // https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc

  Future<void> addEmployee() async {
    final db = await database;

    await db.insert('employees', {});
  }

  Future<void> deleteEmployee() async {
    final db = await database;

    await db.delete('employees', where: 'id = ?', whereArgs: []);
  }
}
