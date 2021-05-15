import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tomasfamilyapp/models/models/Image.dart';
import 'package:tomasfamilyapp/redux/state.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<ImageModel>>(
        converter: (store) => store.state.imgs,
        builder: (context, imgs) {
          return GridView.count(
            crossAxisCount: 2,
            children: imgs.map((ImageModel e) {
              return new Container(
                child: Image.network(e.getUrl()),
              );
            }).toList(),
          );
        },
    );
  }
}