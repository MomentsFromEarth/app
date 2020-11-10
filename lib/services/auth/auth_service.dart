import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../aws/amplify_service.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class AuthServiceError implements Exception { 
  String cause;
  AuthServiceError.init({@required String cause, PlatformException platformException}) {
    this.cause = cause;
  }
}

class AuthService {
  static const defaultPassword = "palebluedot";

  static final _instance = AuthService._internal();

  static final _amplifyErrorMap = {
    "AMPLIFY_CONFIRM_SIGNIN_FAILED":                "MFE_CONFIRM_SIGNIN_FAILED",
    "AMPLIFY_CONFIRM_SIGNUP_FAILED":                "MFE_CONFIRM_SIGNUP_FAILED",
    "AMPLIFY_CONFIRM_PASSWORD_FAILED":              "MFE_CONFIRM_PASSWORD_FAILED",
    "AMPLIFY_GET_CURRENT_USER_FAILED":              "MFE_GET_CURRENT_USER_FAILED",
    "AMPLIFY_RESEND_SIGNUP_CODE_FAILED":            "MFE_RESEND_SIGNUP_CODE_FAILED",
    "AMPLIFY_FETCH_SESSION_FAILED":                 "MFE_FETCH_SESSION_FAILED",
    "AMPLIFY_SIGNIN_FAILED":                        "MFE_SIGNIN_FAILED",
    "AMPLIFY_SIGNOUT_FAILED":                       "MFE_SIGNOUT_FAILED",
    "AMPLIFY_SIGNUP_FAILED":                        "MFE_SIGNUP_FAILED",
    "AMPLIFY_RESET_PASSWORD_FAILED":                "MFE_RESET_PASSWORD_FAILED",
    "AMPLIFY_REQUEST_MALFORMED":                    "MFE_REQUEST_MALFORMED",
    "AMPLIFY_UPDATE_PASSWORD_FAILED":               "MFE_UPDATE_PASSWORD_FAILED",
    "ERROR_CASTING_INPUT_IN_PLATFORM_CODE":         "MFE_ERROR_CASTING_INPUT_IN_PLATFORM_CODE",
    "ERROR_FORMATTING_PLATFORM_CHANNEL_RESPONSE":   "MFE_ERROR_FORMATTING_PLATFORM_CHANNEL_RESPONSE",
    "PLATFORM_EXCEPTIONS":                          "MFE_PLATFORM_EXCEPTIONS",
    "AUTH_PLUGIN_INCORRECTLY_ADDED":                "MFE_AUTH_PLUGIN_INCORRECTLY_ADDED"
  };
  static const _defaultAuthServiceError = "MFE_UNRECOGNIZED_AUTH_ERROR";

  AuthService._internal();

  AmplifyService _amplify = AmplifyService.getInstance();

  init() async {
    try {
      await _amplify.init();
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> loggedIn() async {
    try {
      return await _amplify.isSignedIn();
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> join(String email, String password) async {
    try {
      return await _amplify.signUp(email, password);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> confirmJoin(String email, String inviteToken) async {
    try {
      return await _amplify.confirmSignUp(email, inviteToken);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> resendInviteToken(String email) async {
    try {
      return await _amplify.resendSignUpCode(email);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      return await _amplify.signIn(email, password);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> logout() async {
    try {
      return await _amplify.signOut();
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      return await _amplify.resetPassword(email);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> confirmPassword(String email, String newPassword, String resetToken) async {
    try {
      return await _amplify.confirmPassword(email, newPassword, resetToken);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    try {
      return await _amplify.updatePassword(oldPassword, newPassword);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  static AuthService getInstance() {
    return _instance;
  }

  String _getErrorCause(String amplifyCause) {
    return _amplifyErrorMap[amplifyCause] != null ?  _amplifyErrorMap[amplifyCause] : _defaultAuthServiceError;
  }
}
