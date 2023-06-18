abstract class Failure {
  Failure([
    List properties = const <dynamic>[],
  ]);
}

//general failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
