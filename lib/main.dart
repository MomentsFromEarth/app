import 'package:flutter/material.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';

import './services/aws/amplify_config.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool _amplifyConfigured = false;

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

  void _incrementCounter() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });

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
        confirmationCode: "921849"
      );
      setState(() {
        print("EMAIL CONFIRMED!");
      });
    } on AuthError catch (e) {
      print(e.toString());
      print(e.cause);
    }
    */

    try {
      await Amplify.Auth.signOut();
      SignInResult res2 = await Amplify.Auth.signIn(
        username:"willstepp@gmail.com",
        password: "palebluedot",
      );
      print("SIGNED IN (palebluedot): ${res2.isSignedIn}!");
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

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
