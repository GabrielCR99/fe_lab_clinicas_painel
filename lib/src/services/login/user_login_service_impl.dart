import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/user/user_repository.dart';
import 'user_login_service.dart';

final class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  const UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Unit>> execute({
    required String email,
    required String password,
  }) async {
    final result = await userRepository.login(email: email, password: password);

    switch (result) {
      case Left(value: AuthError()):
        return const Left(ServiceException(message: 'Erro ao realizar login'));
      case Left(value: AuthUnauthorizedException()):
        return const Left(
          ServiceException(message: 'Login ou senha inválidos'),
        );
      case Right(:final value):
        final sp = await SharedPreferences.getInstance();
        await sp.setString(accessToken, value);

        return const Right(unit);
    }
  }
}
