// The repository will catch these exceptions and convert them into Failure, therefore Failures map one to one to Exceptions

import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.message, required this.statusCode});

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [
        message,
        statusCode
      ];
}

// Will be thrown from between the local data source when a cache error happens
class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, required this.statusCode});

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [
        message,
        statusCode
      ];
}

// 404
class ServerException implements Exception {}
