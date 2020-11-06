import 'package:flutter/material.dart';

import './join_page.dart';
import './forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  onJoinPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(JoinPage.routeName);
  }

  onForgotPasswordPressed(BuildContext context) {
    Navigator.of(context).pushNamed(ForgotPasswordPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Join'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onJoinPressed(context),
            ),
            FlatButton(
              child: Text('Forgot [Password]'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onForgotPasswordPressed(context),
            ),
          ]
        )
      )
    );
  }
}