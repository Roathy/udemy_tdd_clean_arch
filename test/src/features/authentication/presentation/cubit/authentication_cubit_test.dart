import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/usecases/create_user.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/usecases/get_users.dart';
import 'package:tdd_clean_arch/src/features/authentication/presentation/cubit/authentication_cubit.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late CreateUser createUser;
  late GetUsers getUsers;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(statusCode: 400, message: 'message');

  setUp(() {
    createUser = MockCreateUser();
    getUsers = MockGetUsers();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, UserCreated] when successful',
      build: () {
        when(() => createUser(any())).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
        createdAt: tCreateUserParams.createdAt,
      ),
      expect: () => const [
        CreatingUser(),
        UserCreated()
      ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, AuthenticationError] when unsuccesful',
      build: () {
        when(() => createUser(any())).thenAnswer((_) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
        createdAt: tCreateUserParams.createdAt,
      ),
      expect: () => [
        const CreatingUser(),
        AuthenticationError(tApiFailure.errorMessage)
      ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>('should emit [GettingUsers, UsersLoaded] when successful',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Right([]));
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => const [
              GettingUsers(),
              UsersLoaded([]),
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationCubit, AuthenticationState>('should emit[ApiExcetion, AuthenticationError] when unsuccesful',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Left(tApiFailure));
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [
              const GettingUsers(),
              AuthenticationError(tApiFailure.errorMessage),
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
