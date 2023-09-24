import 'package:injectable/injectable.dart';

import '../../domain/models/enum/auth_status.dart';
import '../../domain/repository/authorization_repository.dart';
import '../source/auth_source/auth_source.dart';

@Singleton(as: AuthorizationRepository)
class AuthorizationRepositoryImpl implements AuthorizationRepository {
  AuthorizationRepositoryImpl(
    this._authSource,
  );

  final AuthSource _authSource;

  @override
  Future<bool> loginByLoginAndPassword({
    required String login,
    required String password,
  }) async {
    final Future<bool> result = _authSource.loginByLoginAndPassword(login: login, password: password);
    return result;
  }

  @override
  Stream<AuthStatus> get authStatusStream => _authSource.authStatusStream;

  @override
  Future<void> logout() => _authSource.logout();

  @override
  AuthStatus getAuthStatus() => _authSource.authStatus;
}
