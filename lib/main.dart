import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:amplify_core/amplify_core.dart';
import 'amplifyconfiguration.dart';

import 'dart:developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;
  bool isSignUpComplete = false;

  // Instantiate Amplify
  Amplify amplifyInstance = Amplify();

  @override
  void initState() {
    super.initState();
    _configureAmplify(); 
  }

  void _configureAmplify() async {
    if (!mounted) return;

    // Add Cognito Plugins
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    amplifyInstance.addPlugin(authPlugins: [authPlugin]);

    // Once Plugins are added, configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }

  }

  // Send an event to Pinpoint
  void _recordEvent() async {
    /*
    AnalyticsEvent event = AnalyticsEvent("test");
    event.properties.addBoolProperty("boolKey", true);
    event.properties.addDoubleProperty("doubleKey", 10.0);
    event.properties.addIntProperty("intKey", 10);
    event.properties.addStringProperty("stringKey", "stringValue");
    Amplify.Analytics.recordEvent(event: event);
    */

    /*
    try {
      Map<String, dynamic> userAttributes = {
        "email": "willstepp@gmail.com",
      };
      SignUpResult res = await Amplify.Auth.signUp(
        username: "willstepp@gmail.com",
        password: "palebluedot",
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;
        print("SIGNUP COMPLETE!");
      });
    } on AuthError catch (e) {
      print(e.toString());
    }
    */

    /*
    print("EMAIL CONFIRMED: START!");  
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: "willstepp@gmail.com",
        confirmationCode: "365313"
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;
        print("EMAIL CONFIRMED: ${res.isSignUpComplete}!");
      });
    } on AuthError catch (e) {
      print(e.toString());
      print(e.cause);
    }

    try {
      await Amplify.Auth.signOut();
      SignInResult res = await Amplify.Auth.signIn(
        username:"willstepp@gmail.com",
        password: "palebluedot",
      );
      setState(() {
        print("SIGNED IN (palebluedot): ${res.isSignedIn}!");
      });
      try {
        await Amplify.Auth.updatePassword(
          newPassword: "silver55",
          oldPassword: "palebluedot"
        );
        await Amplify.Auth.signOut();
        print("SIGNED OUT");
        SignInResult res2 = await Amplify.Auth.signIn(
          username:"willstepp@gmail.com",
          password: "silver55",
        );
        print("SIGNED IN (silver55): ${res2.isSignedIn}!");
      } on AuthError catch (e) {
        print(e);
        print(e.cause);
      }
    } on AuthError catch (e) {
      print(e);
      print(e.cause);
    }
    */

    /*
    try {
      ResetPasswordResult res = await Amplify.Auth.resetPassword(
        username: "willstepp@gmail.com",
      );
      setState(() {
        print("Reset Sent: ${res.isPasswordReset}!");
      });
    } on AuthError catch (e) {
      print(e);
      print(e.cause);
    }
    */

    /*
    try {
      await Amplify.Auth.confirmPassword(
        username: "willstepp@gmail.com",
        newPassword: "palebluedot",
        confirmationCode: "238672"
      );
      await Amplify.Auth.signOut();
      print("SIGNED OUT");
      SignInResult res2 = await Amplify.Auth.signIn(
        username:"willstepp@gmail.com",
        password: "palebluedot",
      );
      print("SIGNED IN (palebluedot): ${res2.isSignedIn}!");
    } on AuthError catch (e) {
      print(e);
      print(e.cause);
    }
    */

    try {
      /*
      await Amplify.Auth.signOut();
      SignInResult res2 = await Amplify.Auth.signIn(
        username:"willstepp@gmail.com",
        password: "palebluedot",
      );
      print("SIGNED IN (palebluedot): ${res2.isSignedIn}!");
      */
      CognitoAuthSession sess = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));
      if (sess.isSignedIn) {
        print("SIGNED IN");
        print(sess.userPoolTokens.idToken);
      } else {
        print("USER IS NOT SIGNED IN");
      }
    } on AuthError catch (e) {
          print(e);
          print(e.cause);
          print(e.exceptionList[0].detail);
          print(e.exceptionList[1].detail);
    }

    /*Amplify.Auth.fetchAuthSession().startListening((hubEvent) {
      switch(hubEvent["eventName"]) {
        case "SIGNED_IN": {
          print("USER IS SIGNED IN");
        }
        break;
        case "SIGNED_OUT": {
          print("USER IS SIGNED OUT");
        }
        break;
        case "SESSION_EXPIRED": {
          print("USER IS SIGNED IN");
        }
        break;
      }
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Amplify Core example app'),
          ),
          body: ListView(padding: EdgeInsets.all(10.0), children: <Widget>[
            Center( 
              child: Column (
                children: [
                  const Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    _amplifyConfigured ? "configured" : "not configured"
                  ),                  
                  RaisedButton(
                    onPressed: _amplifyConfigured ? _recordEvent : null,
                    child: const Text('record event')
                  )
                ]
              ),
            )
          ])
      )
    );
  }
}
