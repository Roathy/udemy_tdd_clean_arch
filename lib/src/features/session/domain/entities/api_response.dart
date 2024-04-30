import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  const ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final Map data;

  @override
  List<Object?> get props => [
        success,
        message,
        data
      ];
}
