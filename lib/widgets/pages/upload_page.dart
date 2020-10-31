import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  static const routeName = '/archive/upload';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Upload Page',
            )
          ]
        )
      )
    );
  }
}