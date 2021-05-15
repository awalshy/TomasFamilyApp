import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:tomasfamilyapp/screens/SignIn.dart';

class Phone extends StatefulWidget {
  Phone({Key key}) : super(key: key);
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
        },
          child: Text('SignOut'),
        ),
        StoreConnector<AppState, Function()>(
            converter: (store) => () => store.dispatch(LoadGallery()),
          builder: (context, load) {
              return ElevatedButton(onPressed: load, child: Text('Refresh Gallery'));
          },
        )
      ],
    );
  }
}