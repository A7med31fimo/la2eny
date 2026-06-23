import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class ApiFailure extends Failure {
  final int statusCode;
  const ApiFailure({required this.statusCode, required String message})
      : super(message);

  @override
  List<Object> get props => [statusCode, message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database error']);
}

class AiFailure extends Failure {
  const AiFailure([super.message = 'AI engine error']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

class LocationFailure extends Failure {
  const LocationFailure([super.message = 'Location unavailable']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred']);
}
