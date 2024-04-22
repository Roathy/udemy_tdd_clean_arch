import 'package:tdd_clean_arch/core/utils/typedef.dart';

/// Abstract base class for use cases that accept parameters.
///
/// Use cases are the core building blocks of the application's business logic.
/// This class defines the contract for use cases that accept input parameters.
/// Concrete use case implementations should extend this class and provide the
/// implementation for the [call] method.
abstract class UsecaseWithParams<Type, Params> {
  /// Constructs a [UsecaseWithParams] instance.
  const UsecaseWithParams();

  /// Executes the use case with the provided [params].
  ///
  /// Returns a [ResultFuture] that completes with the result of the use case.
  ResultFuture<Type> call(Params params);
}

/// Abstract base class for use cases that do not accept parameters.
///
/// Use cases are the core building blocks of the application's business logic.
/// This class defines the contract for use cases that do not accept any input
/// parameters. Concrete use case implementations should extend this class and
/// provide the implementation for the [call] method.
abstract class UsecaseWithoutParams<Type> {
  /// Constructs a [UsecaseWithoutParams] instance.
  const UsecaseWithoutParams();

  /// Executes the use case.
  ///
  /// Returns a [ResultFuture] that completes with the result of the use case.
  ResultFuture<Type> call();
}
