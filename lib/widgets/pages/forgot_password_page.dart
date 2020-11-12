import 'package:flutter/material.dart';

import './reset_password_page.dart';

import '../../services/auth/auth_service.dart';
import '../../services/settings/settings_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  bool blank(String text) {
    return text == null || text == "";
  }

  onResetPasswordPressed(BuildContext rootContext, BuildContext nestedContext) async {
    try {
      var email = emailController.text;
      if (!blank(email)) {
        var sent = await AuthService.getInstance().resetPassword(email);
        if (sent) {
          await SettingsService.getInstance().setForgotEmail(email);
          Navigator.of(context).pushNamed(ResetPasswordPage.routeName);
        }
      }
    } on AuthServiceError catch (e) {
      var msg = "ERROR[${e.cause}]";
      print("ForgotPasswordPage.onResetPasswordPressed - $msg");
      Scaffold.of(nestedContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/forgot-password'),
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
                      FlatButton(
                        child: Text('RESET [PASSWORD]'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onResetPasswordPressed(rootContext, nestedContext),
                      )
                    ]
                  )
                );
        }
      )
    );
  }
}