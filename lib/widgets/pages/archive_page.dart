import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import './home_page.dart';
import './upload_page.dart';

import '../../services/moment/moment_service.dart';

// J0x4GbWGg

class ArchivePage extends StatelessWidget {
  static const routeName = '/archive/index';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/archive'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Moment'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () async {
                var momentService = MomentService.getInstance();
                var res = await momentService.create({
                  'description': 'This is my description',
                  'filename': 'mycoolfilename.mov',
                  'size': 34343434343,
                  'type': 'mov'
                });
                print("MOMENT");
                print(res.statusCode);
                print(res.data);
              },
            ),
            FlatButton(
              child: Text('Upload'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () {
                Navigator.of(context).pushNamed(UploadPage.routeName);
              },
            ),
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