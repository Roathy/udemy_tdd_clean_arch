import 'package:equatable/equatable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

class Login extends UsecaseWithParams<void, LoginCredentialsParams> {
  const Login(this._repository);

  final AuthRepo _repository;

  @override
  ResultVoid call(LoginCredentialsParams params) async => _repository.login(
        email: params.email,
        password: params.password,
      );
}

class LoginCredentialsParams extends Equatable {
  const LoginCredentialsParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password
      ];
}
