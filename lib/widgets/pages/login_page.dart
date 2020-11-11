import 'package:flutter/material.dart';

import './join_page.dart';
import './forgot_password_page.dart';
import './archive_page.dart';

import '../../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  bool blank(String text) {
    return text == null || text == "";
  }

  onLoginPressed(BuildContext rootContext, BuildContext nestedContext) async {    
    String email = emailController.text;
    String password = passwordController.text;
    try {
      if (!blank(email) && !blank(password)) {
        var loggedIn = await AuthService.getInstance().login(email, password);
        if (loggedIn) {
          Navigator.of(rootContext).pushReplacementNamed(ArchivePage.routeName);
        }
      }
    } on AuthServiceError catch (e) {
      var msg = "ERROR[${e.cause}]";
      switch (e.cause) {
      }
      print("LoginPage.onLoginPressed - $msg");
      Scaffold.of(nestedContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  onJoinPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(JoinPage.routeName);
  }

  onForgotPasswordPressed(BuildContext context) {
    Navigator.of(context).pushNamed(ForgotPasswordPage.routeName);
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/login'),
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
                      FlatButton(
                        child: Text('Login'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onLoginPressed(rootContext, nestedContext),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Join'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onJoinPressed(rootContext),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Forgot Password'),
                        color: Colors.green,
                        textColor: Colors.white70,
                        onPressed: () => onForgotPasswordPressed(rootContext),
                      ),
                    ]
                  )
                );
        }
      )
    );
  }
}