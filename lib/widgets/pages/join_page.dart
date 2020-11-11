import 'package:flutter/material.dart';
import 'dart:async';

import './archive_page.dart';
import './login_page.dart';

import '../../services/auth/auth_service.dart';
import '../../services/settings/settings_service.dart';


class JoinPage extends StatefulWidget {
  static const routeName = '/join';

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () async {
      var email = await SettingsService.getInstance().getString("email");
      if (!blank(email)) {
        emailController.text = email;
      }
    });
  }

  bool blank(String text) {
    return text == null || text == "";
  }

  onLoginPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  onJoinPressed(BuildContext rootContext, BuildContext nestedContext) async {
    String email = emailController.text;
    String token = tokenController.text;
    String password = passwordController.text;
    try {
      if (!blank(email) && !blank(token) && !blank(password)) {
        var authService = AuthService.getInstance();
        await authService.confirmJoin(email, token);
        await authService.logout();
        await authService.login(email, AuthService.defaultPassword);
        await authService.updatePassword(AuthService.defaultPassword, password);
        await authService.logout();
        await authService.login(email, password);
        Navigator.of(rootContext).pushReplacementNamed(ArchivePage.routeName);
      }
    } on AuthServiceError catch (e) {
      print("JoinPage.onJoinPressed - ERROR[${e.cause}]");
      switch (e.cause) {
        case AuthServiceError.ConfirmSignupFailed:
          _showResendInviteTokenDialog(email, nestedContext);
          break;
        default:
          Scaffold.of(nestedContext)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('ERROR[${e.cause}]')));
          break;
      }
    }
  }

  Future<void> _showResendInviteTokenDialog(String email, BuildContext nestedContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ERROR['|'[]|<[-|\\|]"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Unable to confirm Curator Invite', style: TextStyle(color: Colors.black87))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('RESEND'),
              onPressed: () async {
                var authService = AuthService.getInstance();
                await authService.resendInviteToken(email);
                Scaffold.of(nestedContext)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('INVITE RESENT [$email]')));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/join'),
      ),
      body: Builder(
        builder: (BuildContext nestedContext) {
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: tokenController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(0.5)
                          ),
                          hintText: "Curator Invitation ['|'[]|<[-|\\|]",
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Join'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onJoinPressed(rootContext, nestedContext),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Login'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onLoginPressed(rootContext),
                      ),
                    ]
                  )
                );
        }
      )
    );
  }
}