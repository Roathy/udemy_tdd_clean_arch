import 'package:equatable/equatable.dart';

import 'exception.dart';

/// Represents a failure that occurred during an operation.
///
/// The [Failure] class is a base class for representing failures that can occur
/// during an operation. It contains information about the status code and an
/// error message.
///
/// The [ApiFailure] class is a subclass of [Failure] that represents a failure
/// that occurred during an API request.
class Failure extends Equatable {
  const Failure({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [
        statusCode,
        message
      ];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.statusCode, required super.message});

  ApiFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class CacheFailure extends Failure {
  const CacheFailure({required super.statusCode, required super.message});

  CacheFailure.fromException(CacheException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.statusCode, required super.message});

  @override
  List<Object?> get props => [];
}
