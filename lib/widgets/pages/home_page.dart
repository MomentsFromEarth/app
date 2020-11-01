import 'package:flutter/material.dart';

import './register_page.dart';
import './message_curator_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  onAccessArchivePressed(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterPage.routeName);
  }

  onMessageCuratorPressed(BuildContext context) {
    Navigator.of(context).pushNamed(MessageCuratorPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Access [Archive]'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onAccessArchivePressed(context),
            ),
            FlatButton(
              child: Text('Message [Curator]'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onMessageCuratorPressed(context),
            )
          ]
        )
      )
    );
  }
}
