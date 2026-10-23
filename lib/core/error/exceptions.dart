class DatabaseLockedException implements Exception {
  final String message;

  DatabaseLockedException(this.message);
}