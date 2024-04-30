// this is ment to be a contract or interface and should
// define what functionalities the feature carries but
// it doesn't actually implements them, it does not give
// a body to the functions

import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/entities/user.dart';

// por el principio de clean architecture es que en esta capa no
// vamos a lidiar con una Exception, sino que vamos a declarar un
// tipo propio de error
// la capa de Data es la que está expuesta a servidores externos
// y las excepciones son propias de los problemas con servidores
// por lo tanto la capa Data va a recibir y modelar esa Exception
// en un Failure

abstract class AuthenticationRepository {
  ResultVoid createUser({
    required name,
    required createdAt,
    required avatar,
  });

  ResultFuture<List<User>> getUsers();
}
