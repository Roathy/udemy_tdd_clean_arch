import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/newtwork/network_info.dart';
import '../../../../../core/utils/typedef.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture login({
    required email,
    required password,
  }) async {
    if (await networkInfo.isConnected == true) {
      bool isConnected = await networkInfo.isConnected!;
      debugPrint('$isConnected');
      try {
        final result = await remoteDataSource.login(email: email, password: password);
        // await localDataSource.cacheData(key: 'CACHE_SUCCESS', value: result.success);
        // await localDataSource.cacheData(key: 'CACHE_MESSAGE', value: result.message);
        // await localDataSource.cacheData(key: 'CACHE_TOKEN', value: result.data['token']);
        await localDataSource.cacheApiResponse(result.success, result.message, result.data['token']);

        return Right(result);
      } on ApiException catch (e) {
        return Left(ApiFailure.fromException(e));
      }
    } else {
      try {
        // final success = await localDataSource.getLastSuccess();
        // final message = await localDataSource.getLastMessage();
        // final token = await localDataSource.getLastToken();

        // return Right(ApiResponseModel(success: success, message: message, data: {
        //   'token': token
        // }));
        return Right(localDataSource.getLastResponse());
      } on CacheException catch (e) {
        return Left(CacheFailure.fromException(e));
      }
    }
  }
}
