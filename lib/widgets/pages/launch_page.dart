import 'dart:async';
import 'package:flutter/material.dart';

import './home_page.dart';
import './archive_page.dart';

import '../../services/auth/auth_service.dart';

class LaunchPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {

  final launchDelay = 5;

  @override
  void initState() {
    super.initState();
    initAuthAndRedirect();
  }

  void initAuthAndRedirect() async {
    var auth = AuthService.getInstance();
    await auth.init();
    if (await auth.loggedIn()) {
      Timer(Duration(seconds: launchDelay), loadArchivePage);
    } else {
      Timer(Duration(seconds: launchDelay), loadHomePage);
    }
  }

  void loadArchivePage() {
    Navigator.of(context).pushReplacementNamed(ArchivePage.routeName);
  }

  void loadHomePage() {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/mfe-icon-transparent.png',
                        height: 250,
                        width: 250,
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}