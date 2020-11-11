import 'package:flutter/material.dart';
import 'dart:async';

import './archive_page.dart';
import './login_page.dart';

import '../../services/auth/auth_service.dart';
import '../../services/settings/settings_service.dart';


class JoinPage extends StatefulWidget {
  static const routeName = '/join';

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () async {
      var email = await SettingsService.getInstance().getJoinedEmail();
      if (!blank(email)) {
        emailController.text = email;
      }
    });
  }

  bool blank(String text) {
    return text == null || text == "";
  }

  onLoginPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  onJoinPressed(BuildContext rootContext, BuildContext nestedContext) async {
    String email = emailController.text;
    String token = tokenController.text;
    String password = passwordController.text;
    try {
      if (!blank(email) && !blank(token) && !blank(password)) {
        var auth = AuthService.getInstance();
        var settings = SettingsService.getInstance();
        var confirmed = await settings.getJoinedConfirmed();
        if (!confirmed) {
          confirmed = await auth.confirmJoin(email, token);
          await settings.setJoinedConfirmed(confirmed);
        }
        var updated = await settings.getJoinedPassword();
        if (!updated) {
          await auth.logout();
          await auth.login(email, AuthService.defaultPassword);
          updated = await auth.updatePassword(AuthService.defaultPassword, password);
          await settings.setJoinedPassword(updated);
        }
        await auth.logout();
        var loggedIn = await auth.login(email, password);
        if (loggedIn) {
          await settings.removeJoined();
          Navigator.of(rootContext).pushReplacementNamed(ArchivePage.routeName);
        }
      }
    } on AuthServiceError catch (e) {
      var msg = "ERROR[${e.cause}]";
      switch (e.cause) {
        case AuthServiceError.ConfirmSignupFailed:
          switch (e.exception) {
            case AuthServiceError.TokenInvalid:
              _showResendInviteTokenDialog(email, "TOKEN_INVALID", nestedContext);
              break;
            case AuthServiceError.TokenExpired:
              _showResendInviteTokenDialog(email, "TOKEN_EXPIRED", nestedContext);
              break;
            case AuthServiceError.UserNotFound:
              msg = "ERROR[EMAIL_NOT_FOUND]";
              break;
            case AuthServiceError.UserAlreadyConfirmed:
              msg = "ERROR[EMAIL_ALREADY_EXISTS]";
              break;
            default:
              break;
          }
          break;
        case AuthServiceError.UpdatePasswordFailed:
          switch (e.exception) {
            case AuthServiceError.InvalidPassword:
              msg = "ERROR[PASSWORD_INVALID: >= 6 CHARS]";
              break;
            default:
              break;
          }
          break;
        default:
          break;
      }
      print("JoinPage.onJoinPressed - $msg");
      Scaffold.of(nestedContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  Future<void> _showResendInviteTokenDialog(String email, String msg, BuildContext nestedContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ERROR['|'[]|<[-|\\|]"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg, style: TextStyle(color: Colors.black87))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () async {
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: Text('RESEND'),
              onPressed: () async {
                var authService = AuthService.getInstance();
                await authService.resendInviteToken(email);
                Scaffold.of(nestedContext)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('INVITATION RESENT [$email]')));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/join'),
      ),
      body: Builder(
        builder: (BuildContext nestedContext) {
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: tokenController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          hintText: "Curator Invitation ['|'[]|<[-|\\|]",
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Join'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onJoinPressed(rootContext, nestedContext),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Login'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onLoginPressed(rootContext),
                      ),
                    ]
                  )
                );
        }
      )
    );
  }
}