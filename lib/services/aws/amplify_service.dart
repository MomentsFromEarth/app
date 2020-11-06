import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';

import '../aws/amplify_config.dart';

class AmplifyService {
  static final _instance = AmplifyService._internal();

  AmplifyService._internal();

  Amplify amplifyInstance = Amplify();

  init() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    amplifyInstance.addPlugin(authPlugins: [authPlugin]);
    await amplifyInstance.configure(amplifyconfig);
  }

  static AmplifyService getInstance() {
    return _instance;
  }

  Future<bool> isSignedIn() async {
    try {
      CognitoAuthSession sess = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true)
      );
      return sess.isSignedIn;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.isSignedIn]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> signUp(String username, String password) async {
    try {
      Map<String, dynamic> userAttributes = {
        "email": username,
      };
      await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.signUp]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> confirmSignUp(String username, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode
      );
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.confirmSignUp]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> resendSignUpCode(String username) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: username);
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.resendSignUpCode]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> signIn(String username, String password) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return res.isSignedIn;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.signIn]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await Amplify.Auth.signOut();
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.signOut]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> resetPassword(String username) async {
    try {
      await Amplify.Auth.resetPassword(username: username);
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.resetPassword]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> confirmPassword(String username, String newPassword, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode
      );
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.confirmPassword]");
      print(e.cause);
      return false;
    }
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword
      );
      return true;
    } on AuthError catch (e) {
      print("ERROR[AmplifyService.updatePassword]");
      print(e.cause);
      return false;
    }
  }
}
