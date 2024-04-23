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
