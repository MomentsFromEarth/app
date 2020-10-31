import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  static const routeName = '/reset-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/reset-password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Reset Password Page',
            )
          ]
        )
      )
    );
  }
}