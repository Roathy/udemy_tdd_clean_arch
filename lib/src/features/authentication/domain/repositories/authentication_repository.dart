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
/// Defines the contract for an authentication repository.
///
/// The `AuthenticationRepository` interface defines the basic operations
/// for managing user authentication, including creating new users and
/// retrieving a list of existing users.
///
/// Implementations of this interface should not deal with exceptions
/// directly, but rather return a custom `ResultVoid` or `ResultFuture<List<User>>`
/// type to represent the success or failure of the operations.
/// The actual handling of exceptions should be delegated to the data layer.
abstract class AuthenticationRepository {
  /// Creates a new user with the provided [createdAt], [name], and [avatarUrl].
  ///
  /// Returns a `ResultVoid` indicating the success or failure of the operation.
  ResultVoid createUser({
    required name,
    required createdAt,
    required avatarUrl,
  });

  /// Retrieves a list of all registered users.
  ///
  /// Returns a `ResultFuture<List<User>>` containing the list of users, or
  /// an error if the operation fails.
  ResultFuture<List<User>> getUsers();
}
