import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_clean_arch/src/features/session/data/models/api_response_model.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/utils/constants.dart';

abstract class AuthRemoteDataSource {
  Future<Object> login({
    required email,
    required password,
  });
}

const loginEndPoint = '/api/v1/alumno/login';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);
  final http.Client _client;

  @override
  Future<Object> login({
    required email,
    required password,
  }) async {
    try {
      final response = await _client.post(Uri.https(mBaseUrl, loginEndPoint),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'X-App-MirHorizon': '2c87d4de6231dee7d4557627c3812497'
          });
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return ApiResponseModel.fromMap(jsonDecode(response.body));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
