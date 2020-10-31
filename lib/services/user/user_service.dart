class UserService {
  static final _instance = UserService._internal();

  UserService._internal();

  static UserService getInstance() {
    return _instance;
  }
}
