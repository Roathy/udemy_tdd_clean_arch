import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    // arrenge: put together what we need
    // cuando alguien pida crear un usuario regresa el Right del Either
    // con null en por éxito
    when(
      () => repository.createUser(
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
        createdAt: any(named: 'createdAt'),
      ),
      // enforce the answer that you need
    ).thenAnswer((_) async => const Right(null));

    // act
    // make a call to see what answer you get
    final result = await usecase(params);

    // assert
    // compare what you want with what was answered to see if it matches
    expect(result, equals(const Right<dynamic, void>(null)));
    // verify that repository was actually called
    // and called with the precise arguments
    // and just once
    verify(() => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        )).called(1);

    // verify that all communication is terminated
    verifyNoMoreInteractions(repository);
  });
}
