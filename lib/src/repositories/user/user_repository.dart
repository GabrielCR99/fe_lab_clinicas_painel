import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login({
    required String email,
    required String password,
  });
}
