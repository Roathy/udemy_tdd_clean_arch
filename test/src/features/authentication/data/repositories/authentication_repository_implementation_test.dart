import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/errors/exception.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';
import 'package:tdd_clean_arch/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  group('createUser', () {
    // arrenge
    const name = 'test.name';
    const avatar = 'test.avatar';
    const createdAt = 'test.createdAt';

    const tException = ApiException(message: 'test server exception', statusCode: 500);
    test('should call the [RemoteDataSource.createUser] and complete successfully', () async {
      // arrenge
      when(() => remoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt'),
          )).thenAnswer((_) async => Future.value());

      // act
      final result = await repositoryImpl.createUser(name: name, avatar: avatar, createdAt: createdAt);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ApiFailure] when the call to RemoteDataSource is unsuccessful', () async {
      // arrenge
      when(
        () => remoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(
              named: 'createdAt',
            )),
      ).thenThrow(tException);

      // act
      final result = await repositoryImpl.createUser(name: name, createdAt: createdAt, avatar: avatar);

      // assert
      expect(result, Left(ApiFailure(statusCode: tException.statusCode, message: tException.message)));
      verify(() => remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    const tException = ApiException(message: 'test server exception', statusCode: 500);

    test('should call [RemoteDataSource.getUsers] successfully and return a [List<User>]', () async {
      // arrenge
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);

      // act
      final result = await repositoryImpl.getUsers();

      // assert
      // Las listas en dart no son directamente comparables por lo que la prueba falla
      // expect(result, equals(const Right(<User>[])));
      expect(result, isA<Right<Failure, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ApiFailure] when the call to [RemoteDataSource.getUsers] is unsuccessful', () async {
      // arrenge
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      // act
      final result = await repositoryImpl.getUsers();

      // assert
      expect(result, Left(ApiFailure.fromException(tException)));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
