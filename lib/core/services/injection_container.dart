import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../src/features/session/data/datasources/auth_local_data_source.dart';
import '../../src/features/session/data/datasources/auth_remote_data_source.dart';
import '../../src/features/session/data/repositories/auth_repo_impl.dart';
import '../../src/features/session/domain/repositories/auth_repo.dart';
import '../../src/features/session/domain/usecases/login.dart';
import '../../src/features/session/presentation/cubit/authentication_cubit.dart';
import '../newtwork/network_info.dart';
import 'shared_preferences_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // app logic
    ..registerFactory(() => AuthenticationCubit(
          login: sl(),
        ))
    // Usecases
    ..registerLazySingleton(() => Login(sl()))
    // Repositories
    ..registerLazySingleton<AuthRepo>(() {
      return AuthRepoImpl(
        localDataSource: sl<AuthLocalDataSource>(),
        remoteDataSource: sl<AuthRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      );
    })
    // DataSource
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()))
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl<SharedPreferencesService>()))
    // External Dependencies
    ..registerLazySingleton(http.Client.new);

  // Register SharedPreferencesService
  sl.registerLazySingleton(() => SharedPreferencesService());

  // Register NetworkInfoImp with DataConnectionChecker
  sl.registerFactory<NetworkInfo>(() {
    final connectionChecker = DataConnectionChecker();
    return NetworkInfoImp(connectionChecker);
  });
}

// Future<void> init() async {
//   sl
//     // app logic
//     ..registerFactory(() => AuthenticationCubit(
//           createUser: sl(),
//           getUsers: sl(),
//         ))
//     // Usecases
//     ..registerLazySingleton(() => CreateUser(sl()))
//     ..registerLazySingleton(() => GetUsers(sl()))
//     // Repositories
//     ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()))
//     // DataSource
//     ..registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()))
//     // External Dependencies
//     ..registerLazySingleton(http.Client.new);
// }
