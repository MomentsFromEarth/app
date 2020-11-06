import '../aws/amplify_service.dart';

class AuthService {
  static final _instance = AuthService._internal();
  static const defaultPassword = "palebluedot";

  AuthService._internal();

  AmplifyService amplify = AmplifyService.getInstance();

  init() async {
    await amplify.init();
  }

  Future<bool> loggedIn() async {
    return amplify.isSignedIn();
  }

  Future<bool> register(String email, String password) async {
    return amplify.signUp(email, password);
  }

  static AuthService getInstance() {
    return _instance;
  }
}
