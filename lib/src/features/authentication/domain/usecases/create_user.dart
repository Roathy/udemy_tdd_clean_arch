import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/core/usecase/usecase.dart';
import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
        name: params.name,
        createdAt: params.createdAt,
        avatarUrl: params.avatarUrl,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.name,
    required this.createdAt,
    required this.avatarUrl,
  });

  const CreateUserParams.empty()
      : this(
          name: '_empty.name',
          createdAt: '_empty.createdAt',
          avatarUrl: '_empty.avatarUrl',
        );

  final String name;
  final String createdAt;
  final String avatarUrl;

  @override
  List<Object?> get props => [
        name,
        createdAt,
        avatarUrl
      ];
}
