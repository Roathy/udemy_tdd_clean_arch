import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/entities/user.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/usecases/get_users.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [
    User.empty()
  ];

  test('should call [AuthRepo.getUsers] and return a list of all the users', () async {
    // arrenge
    when(
      () => repository.getUsers(),
    ).thenAnswer((_) async => const Right(tResponse));

    // act
    final result = await usecase();

    // assert
    expect(result, equals(List));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
