import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext contect) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('Message Page')],
    );
  }
}