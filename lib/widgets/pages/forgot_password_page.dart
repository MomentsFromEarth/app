import 'package:flutter/material.dart';

import './reset_password_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  static const routeName = '/forgot-password';

  onHaveTokenPressed(BuildContext context) {
    Navigator.of(context).pushNamed(ResetPasswordPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/forgot-password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Have [Token]'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onHaveTokenPressed(context),
            ),
          ]
        )
      )
    );
  }
}