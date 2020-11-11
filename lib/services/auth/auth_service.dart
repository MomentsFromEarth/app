import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../aws/amplify_service.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../settings/settings_service.dart';

class AuthServiceError implements Exception {
  static const ConfirmSigninFailed =                      "MFE_CONFIRM_SIGNIN_FAILED";
  static const ConfirmSignupFailed =                      "MFE_CONFIRM_SIGNUP_FAILED";
  static const ConfirmPasswordFailed =                    "MFE_CONFIRM_PASSWORD_FAILED";
  static const GetCurrentUserFailed =                     "MFE_GET_CURRENT_USER_FAILED";
  static const ResendSignupCodeFailed =                   "MFE_RESEND_SIGNUP_CODE_FAILED";
  static const FetchSessionFailed =                       "MFE_FETCH_SESSION_FAILED";
  static const SigninFailed =                             "MFE_SIGNIN_FAILED";
  static const SignoutFailed =                            "MFE_SIGNOUT_FAILED";
  static const SignupFailed =                             "MFE_SIGNUP_FAILED";
  static const ResetPasswordFailed =                      "MFE_RESET_PASSWORD_FAILED";
  static const RequestMalformed =                         "MFE_REQUEST_MALFORMED";
  static const UpdatePasswordFailed =                     "MFE_UPDATE_PASSWORD_FAILED";
  static const ErrorCastingInputInPlatformCode =          "MFE_ERROR_CASTING_INPUT_IN_PLATFORM_CODE";
  static const ErrorFormattingPlatformChannelResponse =   "MFE_ERROR_FORMATTING_PLATFORM_CHANNEL_RESPONSE";
  static const PlatformExceptions =                       "MFE_PLATFORM_EXCEPTIONS";
  static const AuthPluginIncorrectlyAdded =               "MFE_AUTH_PLUGIN_INCORRECTLY_ADDED";
  static const UnrecognizedAuthError =                    "MFE_UNRECOGNIZED_AUTH_ERROR";

  static const InvalidPassword =                          "MFE_INVALID_PASSWORD";
  static const TokenExpired =                             "MFE_TOKEN_EXPIRED";
  static const TokenInvalid =                             "MFE_TOKEN_INVALID";
  static const UserNotFound =                             "MFE_USER_NOT_FOUND";
  static const UserAlreadyConfirmed =                     "MFE_USER_ALREADY_CONFIRMED";        

  String cause;
  String exception;
  String detail;

  AuthServiceError.init({@required String cause, String exception, String detail, PlatformException platformException}) {
    this.cause = cause;
    this.exception = exception;
    this.detail = detail;
  }
}

class AuthService {
  static const defaultPassword = "palebluedot";

  static final _instance = AuthService._internal();

  static final _amplifyErrorMap = {
    "AMPLIFY_CONFIRM_SIGNIN_FAILED":                AuthServiceError.ConfirmSigninFailed,
    "AMPLIFY_CONFIRM_SIGNUP_FAILED":                AuthServiceError.ConfirmSignupFailed,
    "AMPLIFY_CONFIRM_PASSWORD_FAILED":              AuthServiceError.ConfirmSignupFailed,
    "AMPLIFY_GET_CURRENT_USER_FAILED":              AuthServiceError.GetCurrentUserFailed,
    "AMPLIFY_RESEND_SIGNUP_CODE_FAILED":            AuthServiceError.ResendSignupCodeFailed,
    "AMPLIFY_FETCH_SESSION_FAILED":                 AuthServiceError.FetchSessionFailed,
    "AMPLIFY_SIGNIN_FAILED":                        AuthServiceError.SigninFailed,
    "AMPLIFY_SIGNOUT_FAILED":                       AuthServiceError.SignoutFailed,
    "AMPLIFY_SIGNUP_FAILED":                        AuthServiceError.SignupFailed,
    "AMPLIFY_RESET_PASSWORD_FAILED":                AuthServiceError.ResetPasswordFailed,
    "AMPLIFY_REQUEST_MALFORMED":                    AuthServiceError.RequestMalformed,
    "AMPLIFY_UPDATE_PASSWORD_FAILED":               AuthServiceError.UpdatePasswordFailed,
    "ERROR_CASTING_INPUT_IN_PLATFORM_CODE":         AuthServiceError.ErrorCastingInputInPlatformCode,
    "ERROR_FORMATTING_PLATFORM_CHANNEL_RESPONSE":   AuthServiceError.ErrorFormattingPlatformChannelResponse,
    "PLATFORM_EXCEPTIONS":                          AuthServiceError.PlatformExceptions,
    "AUTH_PLUGIN_INCORRECTLY_ADDED":                AuthServiceError.AuthPluginIncorrectlyAdded
  };

  static final _amplifyExceptionMap = {
    "ALIAS_EXISTS": "",
    "AMAZON_CLIENT_EXCEPTION": "",
    "AMAZON_SERVICE_EXCEPTION": "",
    "CODE_DELIVERY_FAILURE": "",
    "CODE_EXPIRED": AuthServiceError.TokenExpired,
    "CODE_MISMATCH": AuthServiceError.TokenInvalid,
    "CONFIGURATION": "",
    "INTERNAL_ERROR": "",
    "INVALID_ACCOUNT_TYPE": "",
    "INVALID_LAMBDA_RESPONSE": "",
    "INVALID_PARAMETER": AuthServiceError.InvalidPassword,
    "INVALID_PASSWORD": "",
    "INVALID_STATE": "",
    "MFA_METHOD_NOT_FOUND": "",
    "NOT_AUTHORIZED": AuthServiceError.UserAlreadyConfirmed,
    "PASSWORD_RESET_REQUIRED": "",
    "PLATFORM_EXCEPTIONS": "",
    "RESOURCE_NOT_FOUND": "",
    "REQUEST_LIMIT_EXCEEDED": "",
    "SESSION_EXPIRED": "",
    "SESSION_UNAVAILABLE_OFFLINE": "",
    "SESSION_UNAVAILABLE_SERVICE": "",
    "SIGNED_OUT": "",
    "SOFTWARE_TOKEN_MFA_NOT_FOUND": "",
    "TOO_MANY_REQUESTS": "",
    "USERNAME_EXISTS": "",
    "UNEXPECTED_LAMBDA": "",
    "USER_LAMBDA_VALIDATION": "",
    "USER_NOT_CONFIRMED": "",
    "USER_NOT_FOUND": AuthServiceError.UserNotFound,
    "TOO_MANY_FAILED_REQUESTS": "",
    "VALIDATION": "",
  };

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
    return await _amplify.isSignedIn();
  }

  Future<bool> join(String email, String password) async {
    try {
      return await _amplify.signUp(email, password);
    } on AuthError catch (e) {
      throw AuthServiceError.init(cause: _getErrorCause(e.cause));
    }
  }

  Future<bool> joinMessageCurator(String email) async {
    bool success = await join(email, defaultPassword);
    if (success) {
      await SettingsService.getInstance().setJoined(email);
    }
    return true;
  }

  Future<bool> confirmJoin(String email, String inviteToken) async {
    try {
      return await _amplify.confirmSignUp(email, inviteToken);
    } on AuthError catch (e) {
      var exception;
      var detail;
      e.exceptionList.forEach((i) {
        switch (i.exception) {
          case "NOT_AUTHORIZED":
            exception = i.exception;
            detail = i.detail;
            break;
          case "USER_NOT_FOUND":
            exception = i.exception;
            detail = i.detail;
            break;
          case "CODE_MISMATCH":
            exception = i.exception;
            detail = i.detail;
            break;
          case "CODE_EXPIRED":
            exception = i.exception;
            detail = i.detail;
            break;
          default:
            break;
        }
      });
      throw AuthServiceError.init(cause: _getErrorCause(e.cause), exception: _getErrorException(exception), detail: detail);
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
      var exception;
      var detail;
      e.exceptionList.forEach((i) {
        switch (i.exception) {
          case "INVALID_PARAMETER":
            exception = i.exception;
            detail = i.detail;
            break;
          default:
            break;
        }
      });
      throw AuthServiceError.init(cause: _getErrorCause(e.cause), exception: _getErrorException(exception), detail: detail);
    }
  }

  static AuthService getInstance() {
    return _instance;
  }

  String _getErrorException(String amplifyException) {
    return _amplifyExceptionMap[amplifyException] != null ? _amplifyExceptionMap[amplifyException] : null;
  }

  String _getErrorCause(String amplifyCause) {
    return _amplifyErrorMap[amplifyCause] != null ?  _amplifyErrorMap[amplifyCause] : AuthServiceError.UnrecognizedAuthError;
  }
}
