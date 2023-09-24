import '../models/enum/auth_status.dart';

abstract class AuthorizationRepository {
  Stream<AuthStatus> get authStatusStream;

  AuthStatus getAuthStatus();

  Future<bool> loginByLoginAndPassword({
    required String login,
    required String password,
  });

  Future<void> logout();
}
