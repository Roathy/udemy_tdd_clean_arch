import '../../../../../core/utils/typedef.dart';

abstract class AuthRepo {
  ResultFuture login({
    required email,
    required password,
  });
}
