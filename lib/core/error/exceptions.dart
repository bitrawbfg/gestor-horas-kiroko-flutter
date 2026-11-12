class DatabaseLockedException implements Exception {
  final String message;

  DatabaseLockedException(this.message);
}

class ObjectNotFoundByIdException implements Exception {
  final String message;

  ObjectNotFoundByIdException(this.message);
}

class NoObjectsModifiedException implements Exception {
  final String message;

  NoObjectsModifiedException(this.message);
}

class UnexpectedOpenTimeTrackValueException implements Exception {
  final String message;

  UnexpectedOpenTimeTrackValueException(this.message);
}
