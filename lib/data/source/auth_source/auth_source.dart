import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/enum/auth_status.dart';
import 'auth_keys.dart';
import 'dto/user/user_dto.dart';

@preResolve
@singleton
class AuthSource with AuthKeys {
  AuthSource._(this._rxPrefs);
  final RxSharedPreferences _rxPrefs;
  late final BehaviorSubject<AuthStatus> _authorizationStatusSubject;

  @factoryMethod
  static Future<AuthSource> create() async {
    final RxSharedPreferences rxPrefs = RxSharedPreferences.getInstance();
    final AuthSource instance = AuthSource._(rxPrefs);
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    final AuthStatus authStatus = await _rxPrefs.getBool(authStatusKey).then(
          (bool? value) => value ?? false ? AuthStatus.authorized : AuthStatus.unauthorized,
        );
    _authorizationStatusSubject = BehaviorSubject<AuthStatus>.seeded(authStatus);
    _authorizationStatusSubject.addStream(
      _rxPrefs.getBoolStream(authStatusKey).map(
            (bool? event) => event ?? false ? AuthStatus.authorized : AuthStatus.unauthorized,
          ),
    );

    await setUser('{"login": "neirodev", "password": "evgenytest"}');
  }

  Stream<AuthStatus> get authStatusStream => _authorizationStatusSubject;

  AuthStatus get authStatus => _authorizationStatusSubject.value;

  Future<void> setAuthStatus(AuthStatus status) => _rxPrefs.setBool(authStatusKey, status == AuthStatus.authorized);

  Future<void> setUser(String data) => _rxPrefs.setString(userKey, data);

  Future<bool> loginByLoginAndPassword({
    required String login,
    required String password,
  }) async {
    final String? userData = await _rxPrefs.getString(userKey);
    final Map<String, dynamic> json = jsonDecode(userData!) as Map<String, dynamic>;
    final UserDto user = UserDto.fromJson(json);

    final bool isCorrect = login == user.login && password == user.password;
    if (isCorrect) {
      await setAuthStatus(AuthStatus.authorized);
    }
    return isCorrect;
  }

  Future<void> logout() => setAuthStatus(AuthStatus.unauthorized);

  Future<void> clear() => _rxPrefs.clear();
}
