import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';

/// Represents a Future that returns an Either of a [Failure] or a generic type [T].
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Represents a Future that returns an Either of a [Failure] or `void`.
typedef ResultVoid = Future<Either<Failure, void>>;
