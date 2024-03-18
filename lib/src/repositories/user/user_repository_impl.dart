import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  const UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response(data: {'access_token': String accessToken}!) =
          await restClient.unAuth.post<Map<String, dynamic>?>(
        '/auth',
        data: {'email': email, 'password': password, 'admin': true},
      );

      return Right(accessToken);
    } on DioException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);

      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          const Left(AuthUnauthorizedException()),
        _ => const Left(AuthError(message: 'Erro ao realizar login')),
      };
    }
  }
}
