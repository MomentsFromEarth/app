import 'package:flutter/material.dart';

import './archive_page.dart';

import '../../services/auth/auth_service.dart';
import '../../services/settings/settings_service.dart';

class ResetPasswordPage extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
final passwordController = TextEditingController();
final tokenController = TextEditingController();

  bool blank(String text) {
    return text == null || text == "";
  }

  onChangePasswordPressed(BuildContext rootContext, BuildContext nestedContext) async {
    try {
      var password = passwordController.text;
      var token = tokenController.text;
      var email = await SettingsService.getInstance().getForgotEmail();
      if (!blank(email) && !blank(password) && !blank(token)) {
        var auth = AuthService.getInstance();
        var changed = await auth.confirmPassword(email, password, token);
        if (changed) {
          await auth.logout();
          var loggedIn = await auth.login(email, password);
          if (loggedIn) {
            Navigator.of(context).pushNamed(ArchivePage.routeName);
          }
        }
      }
    } on AuthServiceError catch (e) {
      var msg = "ERROR[${e.cause}]";
      switch (e.cause) {
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
      print("ResetPasswordPage.onChangePasswordPressed - $msg");
      Scaffold.of(nestedContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/reset-password'),
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
                          hintText: "Reset ['|'[]|<[-|\\|]",
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('CHANGE [PASSWORD]'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onChangePasswordPressed(rootContext, nestedContext),
                      )
                    ]
                  )
                );
        }
      )
    );
  }
}