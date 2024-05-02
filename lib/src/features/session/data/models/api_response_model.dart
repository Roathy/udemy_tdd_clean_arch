import 'dart:convert';

import '../../../../../core/utils/typedef.dart';
import '../../domain/entities/api_response.dart';

class ApiResponseModel extends ApiResponse {
  const ApiResponseModel({
    required super.success,
    required super.message,
    required super.data,
  });

  factory ApiResponseModel.fromJson(String source) => ApiResponseModel.fromMap(jsonDecode(source) as DataMap);

  ApiResponseModel.fromMap(DataMap map)
      : this(
          success: map['success'] as bool,
          message: map['message'] as String,
          data: map['data'] as DataMap,
        );

  DataMap toMap() => {
        'success': success,
        'message': message,
        'data': data,
      };

  ApiResponseModel copyWith({
    bool? success,
    String? message,
    Map? data,
  }) {
    return ApiResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  String toJson() => jsonEncode(toMap());
}
