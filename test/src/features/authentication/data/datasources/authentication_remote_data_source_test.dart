import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/errors/exception.dart';
import 'package:tdd_clean_arch/core/utils/constants.dart';
import 'package:tdd_clean_arch/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/features/authentication/data/models/user_model.dart';

class MockHttp extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockHttp();
    remoteDataSource = AuthRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('remote data source', () {
    group('createUser', () {
      test('should create an user successfully with a status code 200 or 201', () async {
        // arrenge
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer((_) async => http.Response('user created', 201));

        // act
        final methodCall = remoteDataSource.createUser;

        // assert
        expect(
            methodCall(
              name: 'name',
              avatar: 'avatar',
              createdAt: 'createdAt',
            ),
            completes);

        verify(() => client.post(Uri.https(kBaseUrl, createUserEndPoint),
            body: jsonEncode({
              'name': 'name',
              'avatar': 'avatar',
              'createdAt': 'createdAt'
            }))).called(1);
        verifyNoMoreInteractions(client);
      });

      test('should return an [ApiException] when the status code is different from 200 or 201', () async {
        // arrenge
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer((_) async => http.Response('test server error', 400));

        // act
        final methodCall = remoteDataSource.createUser;

        // assert
        expect(() async => methodCall(name: 'name', avatar: 'avatar', createdAt: 'createdAt'), throwsA(const ApiException(message: 'test server error', statusCode: 400)));
        verify(() => client.post(Uri.https(kBaseUrl, createUserEndPoint),
                body: jsonEncode({
                  'name': 'name',
                  'avatar': 'avatar',
                  'createdAt': 'createdAt'
                }),
                headers: {
                  'Content-Type': 'Application/json'
                })).called(1);
        verifyNoMoreInteractions(client);
      });
    });

    group('getUsers', () {
      // arrenge
      const tUsers = [
        UserModel.empty()
      ];

      test('should return a [List<UserModel>] when the status code is 200 or 201', () async {
        // arrenge
        when(() => client.get(any())).thenAnswer((_) async => http.Response(
            jsonEncode([
              tUsers.first.toMap()
            ]),
            200));

        // act
        final result = await remoteDataSource.getUsers();

        // assert
        expect(result, equals(tUsers));
        verify(() => client.get(Uri.https(
              kBaseUrl,
              getUsersEndPoint,
              // {},
            ))).called(1);
        verifyNoMoreInteractions(client);
      });

      test('should throw an [ApiException] when status code is neither 200 nor 201', () async {
        // arrenge
        when(() => client.get(Uri.https(kBaseUrl, getUsersEndPoint))).thenAnswer((_) async => http.Response('server test error', 400));

        // act
        final methodCall = remoteDataSource.getUsers;

        // assert
        expect(() => methodCall(), throwsA(const ApiException(message: 'server test error', statusCode: 400)));
        verify(() => client.get(Uri.https(kBaseUrl, getUsersEndPoint))).called(1);
        verifyNoMoreInteractions(client);
      });
    });
  });
}
