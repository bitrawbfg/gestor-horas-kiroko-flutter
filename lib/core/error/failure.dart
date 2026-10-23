sealed class Failure {
  final String message;

  const Failure(this.message);
}

class DatabaseLockedFailure extends Failure {
  const DatabaseLockedFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}