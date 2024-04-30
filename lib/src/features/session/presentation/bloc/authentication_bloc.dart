import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/src/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../domain/usecases/login.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required Login login,
  })  : _login = login,
        super(AuthenticationInitial()) {
    // on<AuthenticationEvent>((event, emit) {});
    on<LoginEvent>(_loginHandler);
  }

  final Login _login;

  Future<void> _loginHandler(
    LoginEvent event,
  ) async {
    emit(const CreatingLogin());

    final result = await _login(LoginCredentialsParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => null,
    );
  }
}
