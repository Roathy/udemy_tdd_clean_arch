import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/src/features/authentication/data/datasources/authentication_remote_data_source.dart';

class MockHttp extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockHttp();
    remoteDataSource = AuthRemoteDataSourceImpl(client);
  });

  group('remote data source', () {
    group('createUser', () {
      test('should complete successfully with a status code 200 or 201', () async {
        // arrenge
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('user created', 200),
        );

        // act
        final methodCall = remoteDataSource.createUser;

        // assert
        expect(() => methodCall(name: 'name', avatar: 'avatar', createdAt: 'createdAt'), completes);
        verify(() => client.post());
      });
    });

    group('getUsers', () {});
  });
}
