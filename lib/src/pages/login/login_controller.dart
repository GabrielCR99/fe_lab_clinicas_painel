import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../services/login/user_login_service.dart';

final class LoginController with MessagesControllerMixin {
  final _obscurePassword = signal(true, autoDispose: true);
  bool get obscurePassword => _obscurePassword();

  final _logged = signal(false, autoDispose: true);
  bool get logged => _logged();

  final UserLoginService _userLoginService;

  LoginController({required UserLoginService userLoginService})
      : _userLoginService = userLoginService;

  void toggleObscurePassword() =>
      _obscurePassword.value = !_obscurePassword.value;

  Future<void> login({required String email, required String password}) async {
    final result = await _userLoginService
        .execute(email: email, password: password)
        .asyncLoader();

    return switch (result) {
      Left(:final value) => showError(value.message),
      Right() => _logged.value = true,
    };
  }
}
