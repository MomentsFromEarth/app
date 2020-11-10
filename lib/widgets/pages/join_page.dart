import 'package:flutter/material.dart';

import './login_page.dart';

import '../../services/auth/auth_service.dart';

class JoinPage extends StatefulWidget {
  static const routeName = '/join';

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final emailController =  TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();

  bool blank(String text) {
    return text == null || text == "";
  }

  onLoginPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  onJoinPressed(BuildContext context) async {
    try {
      String email = emailController.text;
      String token = tokenController.text;
      if (!blank(email) && !blank(token)) {
        bool confirmed = await AuthService.getInstance().confirmJoin(emailController.text, tokenController.text);
        if (confirmed) {
          // sign in
          // update password using AuthService.defaultPassword and passwordController.text
          // sign out
          // sign in
          // nav to ArchivePage
        } else {
          // prompt to resend invitation token
        }
      }
    } on AuthServiceError catch (e) {
      print("JoinPage::onJoinPressed.error[${e.cause}]");
      // show snackbar error, unless MFE_CONFIRM_SIGNUP_FAILED, at which prompt to resend invitation token
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/join'),
      ),
      body: Center(
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
              onPressed: () => onJoinPressed(context),
            ),
            SizedBox(height: 10),
            FlatButton(
              child: Text('Login'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onLoginPressed(context),
            ),
          ]
        )
      )
    );
  }
}