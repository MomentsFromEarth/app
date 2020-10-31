import 'package:flutter/material.dart';

class ArchivePage extends StatelessWidget {
  static const routeName = '/archive/index';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archive'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Archive Page',
            )
          ]
        )
      )
    );
  }
}