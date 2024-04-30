import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/errors/exception.dart';
import '../../../../../core/utils/constants.dart';

abstract class AuthRemoteDataSource {
  Future<void> login({
    required email,
    required password,
  });
}

const loginEndPoint = '/alumno/login';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);
  final http.Client _client;

  @override
  Future<void> login({
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
            'Content-Type': 'application/json'
          });
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
