import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override List<Object> get props => [message];
}
class NetworkFailure extends Failure { const NetworkFailure([super.message = 'No internet']); }
class ApiFailure extends Failure {
  final int statusCode;
  const ApiFailure({required this.statusCode, required String message}) : super(message);
  @override List<Object> get props => [statusCode, message];
}
class DatabaseFailure extends Failure { const DatabaseFailure([super.message = 'DB error']); }
class AiFailure extends Failure { const AiFailure([super.message = 'AI error']); }
class AuthFailure extends Failure { const AuthFailure([super.message = 'Auth failed']); }
class UnexpectedFailure extends Failure { const UnexpectedFailure([super.message = 'Unexpected error']); }
