import 'package:http/http.dart' as http;

import '../user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}

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
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    throw UnimplementedError();
  }
}
