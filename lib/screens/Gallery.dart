import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext contect) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('Gallery Page')],
    );
  }
}