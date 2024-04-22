// this is ment to be a contract or interface and should
// define what functionalities the feature carries but
// it doesn't actually implements them, it does not give
// a body to the functions

import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

// por el principio de clean architecture es que en esta capa no
// vamos a lidiar con una Exception, sino que vamos a declarar un
// tipo propio de error
// la capa de Data es la que está expuesta a servidores externos
// y las excepciones son propias de los problemas con servidores
// por lo tanto la capa Data va a recibir y modelar esa Exception
// en un Failure
  Future<Either<Failure, void>> createUser({
    required createdAt,
    required name,
    required avatarUrl,
  });

  Future<List<User>> getUsers();
}
