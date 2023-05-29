import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server Failure'}) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({String message = 'Failed to Connect'}) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({String message = 'Database Failure'}) : super(message);
}

class SSLFailure extends Failure {
  const SSLFailure({String message = 'CERTIFICATE_VERIFY_FAILED'}) : super(message);
}
