import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tomasfamilyapp/screens/SignIn.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void signOut() {
    FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext contect) => SignIn())));
  }

  void crash() {
    FirebaseCrashlytics.instance.crash();
  }

  @override
  Widget build(BuildContext contect) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              signOut();
            },
            child: Text('Se Deconnecter')),
        ElevatedButton(
            onPressed: () {
              crash();
            },
            child: Text('Make it crash'))
      ],
    );
  }
}
