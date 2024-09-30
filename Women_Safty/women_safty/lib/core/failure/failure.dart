abstract class Failure {
  get message => null;
  
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({
    required this.message,
  });
}