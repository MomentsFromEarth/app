import 'package:flutter/material.dart';

import './join_page.dart';
import './message_curator_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  onAccessArchivePressed(BuildContext context) {
    Navigator.of(context).pushNamed(JoinPage.routeName);
  }

  onMessageCuratorPressed(BuildContext rootContext, BuildContext nestedContext) async {
    final dynamic messageSent = await Navigator.push(
      nestedContext,
      MaterialPageRoute(builder: (ctx) => MessageCuratorPage()),
    );
    if (messageSent == true) {
      Scaffold.of(nestedContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Message Sent [Curator]')));
    }
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/home'),
      ),
      body: Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext nestedContext) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Access [Archive]'),
                  color: Colors.green,
                  textColor: Colors.white70,
                  onPressed: () => onAccessArchivePressed(rootContext),
                ),
                FlatButton(
                  child: Text('Message [Curator]'),
                  color: Colors.green,
                  textColor: Colors.white70,
                  onPressed: () => onMessageCuratorPressed(rootContext, nestedContext),
                )
              ]
            )
          );
        }
      )
    );
  }
}
