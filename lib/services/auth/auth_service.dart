import '../aws/amplify_service.dart';

class AuthService {
  static final _instance = AuthService._internal();

  AuthService._internal();

  AmplifyService amplify = AmplifyService.getInstance();

  init() async {
    await amplify.init();
  }

  Future<bool> loggedIn() async {
    return amplify.loggedIn();
  }

  static AuthService getInstance() {
    return _instance;
  }
}
