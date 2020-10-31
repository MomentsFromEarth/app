import 'package:flutter/material.dart';

import './login_page.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';

  onLoginPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Login'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onLoginPressed(context),
            ),
          ]
        )
      )
    );
  }
}