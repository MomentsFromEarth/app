import 'package:flutter/material.dart';
import '../../services/auth/auth_service.dart';

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
    return text != null && text != "";
  }

  onSendMessagePressed(BuildContext context) async {
    if (!blank(emailController.text) && !blank(messageController.text)) {
      await AuthService.getInstance().register(emailController.text, defaultPassword);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST@MFE: ~/message-curator'),
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