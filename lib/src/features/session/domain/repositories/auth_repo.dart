import '../../../../../core/utils/typedef.dart';

abstract class AuthRepo {
  ResultVoid login({
    required email,
    required password,
  });
}
