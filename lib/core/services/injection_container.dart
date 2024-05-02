import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../src/features/session/data/datasources/auth_remote_data_source.dart';
import '../../src/features/session/data/repositories/auth_repo_impl.dart';
import '../../src/features/session/domain/repositories/auth_repo.dart';
import '../../src/features/session/domain/usecases/login.dart';
import '../../src/features/session/presentation/cubit/authentication_cubit.dart';

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
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    // DataSource
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()))
    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;

// import '../../src/features/authentication/data/datasources/authentication_remote_data_source.dart';
// import '../../src/features/authentication/data/repositories/authentication_repository_impl.dart';
// import '../../src/features/authentication/domain/repositories/authentication_repository.dart';
// import '../../src/features/authentication/domain/usecases/create_user.dart';
// import '../../src/features/authentication/domain/usecases/get_users.dart';
// import '../../src/features/authentication/presentation/cubit/authentication_cubit.dart';

// final sl = GetIt.instance;

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
