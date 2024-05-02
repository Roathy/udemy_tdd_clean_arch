import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/src/features/session/data/models/api_response_model.dart';

import '../../domain/usecases/login.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required Login login,
  })  : _login = login,
        super(const AuthenticationInitial());

  final Login _login;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const CreatingUser());

    final result = await _login(LoginCredentialsParams(
      email: email,
      password: password,
    ));

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (response) => emit(UsersLoaded(response)),
    );
  }
}
