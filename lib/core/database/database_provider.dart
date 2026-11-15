import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract interface class DatabaseProvider {
  Future<Database> get database;
}
