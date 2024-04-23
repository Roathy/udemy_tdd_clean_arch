import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required name,
    required createdAt,
    required avatar,
  }) async {
    // TDD - Call the remote data source
    // check if the method returns the proper data
    //  // check if when the remoteDataSource throws an exception, we return a
    // // failure and if it doesn't throw an exception, we return the actual
    // // expected data
    try {
      await _remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
