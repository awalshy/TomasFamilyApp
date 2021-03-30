import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Screens
import 'package:tomasfamilyapp/screens/Layout.dart';
import 'package:tomasfamilyapp/screens/SignIn.dart';
// Providers
import 'package:tomasfamilyapp/providers/ProfileProvider.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Color.fromRGBO(19, 60, 109, 255);
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _versionName = 'V0.0.1';
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final widget = await profile.isLogged() ? Layout() : SignIn();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>  widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF133C6D),
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/TomasLogoLight.png',
                        height: 400,
                        width: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Spacer(),
                            Text(
                              _versionName,
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(
                              flex: 4,
                            ),
                            Text('Loading...',
                                style: TextStyle(color: Colors.white)),
                            Spacer(),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
