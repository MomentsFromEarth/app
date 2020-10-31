class AuthService {
  static final _instance = AuthService._internal();

  AuthService._internal();

  static AuthService getInstance() {
    return _instance;
  }
}
