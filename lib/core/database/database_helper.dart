import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }


  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE employees (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL
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
