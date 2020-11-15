import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';

import './amplify_configuration.dart';

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
      print("AmplifyService.isSignedIn - ERROR[${e.cause}]");
      return false;
    }
  }

  Future<String> idToken() async {
    try {
      CognitoAuthSession sess = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true)
      );
      return sess.userPoolTokens.idToken;
    } on AuthError catch (e) {
      print("AmplifyService.idToken - ERROR[${e.cause}]");
      return null;
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
    } on AuthError catch (e) {
      print("AmplifyService.signUp - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }

  Future<bool> confirmSignUp(String username, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode
      );
    } on AuthError catch (e) {
      print("AmplifyService.confirmSignUp - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }

  Future<bool> resendSignUpCode(String username) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: username);
    } on AuthError catch (e) {
      print("AmplifyService.resendSignUpCode - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }

  Future<bool> signIn(String username, String password) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return res.isSignedIn;
    } on AuthError catch (e) {
      print("AmplifyService.signIn - ERROR[${e.cause}]");
      throw e;
    }
  }

  Future<bool> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthError catch (e) {
      print("AmplifyService.signOut - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }

  Future<bool> resetPassword(String username) async {
    try {
      await Amplify.Auth.resetPassword(username: username);
    } on AuthError catch (e) {
      print("AmplifyService.resetPassword - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }

  Future<bool> confirmPassword(String username, String newPassword, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode
      );
    } on AuthError catch (e) {
      print("AmplifyService.confirmPassword - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword
      );
    } on AuthError catch (e) {
      print("AmplifyService.updatePassword - ERROR[${e.cause}]");
      throw e;
    }
    return true;
  }
}
