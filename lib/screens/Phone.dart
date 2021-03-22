import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  Phone({Key key}) : super(key: key);
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext contect) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('Phone Page')],
    );
  }
}