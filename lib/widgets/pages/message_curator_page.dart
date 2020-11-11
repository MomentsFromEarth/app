import 'package:flutter/material.dart';
import 'dart:async';

import '../../services/auth/auth_service.dart';
import '../../services/settings/settings_service.dart';

class MessageCuratorPage extends StatefulWidget {
  static const routeName = '/message-curator';

  @override
  _MessageCuratorPageState createState() => _MessageCuratorPageState();
}

class _MessageCuratorPageState extends State<MessageCuratorPage> {
  final emailController =  TextEditingController();
  final messageController = TextEditingController();

  final defaultPassword = 'palebluedot';

  bool blank(String text) {
    return text == null || text == "";
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () async {
      var email = await SettingsService.getInstance().getJoinedEmail();
      if (!blank(email)) {
        emailController.text = email;
      }
    });
  }

  onSendMessagePressed(BuildContext context) async {
    if (!blank(emailController.text) && !blank(messageController.text)) {
      await AuthService.getInstance().joinMessageCurator(emailController.text);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/message-curator'),
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
              controller: messageController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(0.5)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(0.5)
                ),
                hintText: 'Message',
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
              child: Text('Send Message [Curator]'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: () => onSendMessagePressed(context),
            ),
          ]
        )
      )
    );
  }
}