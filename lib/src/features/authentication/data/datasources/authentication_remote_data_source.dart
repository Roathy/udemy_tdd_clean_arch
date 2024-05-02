import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/errors/exception.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/typedef.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}

const createUserEndPoint = '/test-api/users';
const getUsersEndPoint = '/test-api/users';

class AuthRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);
  final http.Client _client;

  @override
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    // 1. make sure that it returns the right data when status code is 200
    // 2. make sure that it throws custom exception on status code is bad
    try {
      final response = await _client.post(Uri.https(kBaseUrl, createUserEndPoint),
          body: jsonEncode({
            'name': name,
            // 'avatar': avatar,
            'createdAt': createdAt
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

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, getUsersEndPoint));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List).map((userData) => UserModel.fromMap(userData)).toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
