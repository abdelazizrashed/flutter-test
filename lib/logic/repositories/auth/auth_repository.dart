import 'package:evaluation_project/domain/models/auth/auth_model.dart';
import 'package:evaluation_project/service_locator.dart';

abstract class AuthRepository {
  static AuthRepository get() => getIt.get<AuthRepository>();

  Future<AuthModel?> login(
    String phone,
    String pass, {
    required Function(String message) onError,
  });
  Future<AuthModel?> register(
    String name,
    String phone,
    String email,
    String pass,
    String confirmPass, {
    required Function(String message) onError,
  });
  Future<bool> logout();

  bool isLoggedIn();
}
