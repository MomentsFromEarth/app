import 'package:flutter/material.dart';

class MomentPage extends StatelessWidget {
  static const routeName = '/archive/moment';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Moment Page',
            )
          ]
        )
      )
    );
  }
}