import 'package:flutter/material.dart';

import './widgets/pages/launch_page.dart';
import './widgets/pages/home_page.dart';
import './widgets/pages/login_page.dart';
import './widgets/pages/register_page.dart';
import './widgets/pages/forgot_password_page.dart';
import './widgets/pages/reset_password_page.dart';
import './widgets/pages/archive_page.dart';
import './widgets/pages/admin_page.dart';
import './widgets/pages/upload_page.dart';
import './widgets/pages/message_curator_page.dart';
import './widgets/pages/moment_page.dart';

void main() {
  runApp(MfeApp());
}

class MfeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'momentsfromEarth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        canvasColor: Color.fromRGBO(25, 26, 25, 1),
        fontFamily: 'Inconsolata',
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.white70,
          displayColor: Colors.white70
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        LaunchPage.routeName: (ctx) => LaunchPage(),
        HomePage.routeName: (ctx) => HomePage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        RegisterPage.routeName: (ctx) => RegisterPage(),
        ForgotPasswordPage.routeName: (ctx) => ForgotPasswordPage(),
        ResetPasswordPage.routeName: (ctx) => ResetPasswordPage(),
        MessageCuratorPage.routeName: (ctx) => MessageCuratorPage(),
        ArchivePage.routeName: (ctx) => ArchivePage(),
        MomentPage.routeName: (ctx) => MomentPage(),
        AdminPage.routeName: (ctx) => AdminPage(),
        UploadPage.routeName: (ctx) => UploadPage(),
      }
    );
  }
}
