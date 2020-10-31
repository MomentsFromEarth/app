import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static const routeName = '/archive/admin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Page',
            )
          ]
        )
      )
    );
  }
}