sealed class Failure {
  final String message;

  const Failure(this.message);
}

class DatabaseLockedFailure extends Failure {
  const DatabaseLockedFailure(super.message);
}

class NoObjectsFoundFailure extends Failure {
  const NoObjectsFoundFailure(super.message);
}

class NoObjectsModifiedFailure extends Failure {
  const NoObjectsModifiedFailure(super.message);
}

class UnexpectedOpenTimeTrackValueFailure extends Failure {
  const UnexpectedOpenTimeTrackValueFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
