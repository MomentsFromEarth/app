import 'package:flutter/material.dart';

class MessageCuratorPage extends StatelessWidget {
  static const routeName = '/message-curator';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/message-curator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Message Curator Page',
            )
          ]
        )
      )
    );
  }
}