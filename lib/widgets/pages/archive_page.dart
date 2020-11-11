import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import './home_page.dart';

class ArchivePage extends StatelessWidget {
  static const routeName = '/archive/index';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('theSantiagoDog@MFE: ~/archive/index'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Logout'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () {
                AuthService.getInstance().logout();
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),
          ]
        )
      )
    );
  }
}