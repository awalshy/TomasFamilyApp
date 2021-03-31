import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tomasfamilyapp/screens/Unboarding.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final String animationPath = 'assets/tomas_logo.riv';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _familyCodeController = TextEditingController();
  Artboard _artboard;
  double _size = 0;
  bool _keyboardOpen = false;

  @override
  void initState() {
    super.initState();
    _loadRive();
    final keyboadController = KeyboardVisibilityController();
    keyboadController.onChange.listen((bool visible) {
      setState(() {
        _keyboardOpen = visible;
        _size = MediaQuery.of(context).size.width * (_keyboardOpen ? 0.4 : 0.8);
      });
    });
  }

  void _loadRive() async {
    final bytes = await rootBundle.load(animationPath);
    final file = RiveFile();

    if (file.import(bytes)) {
      setState(() {
        _artboard = file.mainArtboard..addController(SimpleAnimation('eyes'));
      });
    }
  }

  void signUp() async {
    UserCredential user;
    try {
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      var snack;
      if (e.code == 'weak-password')
        snack = SnackBar(
          content: Text('Le mot de passe est trop faible'),
        );
      if (e.code == 'email-already-in-use')
        snack = SnackBar(content: Text('Un compte existe déjà avec cet email'));
      if (snack != null) ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    if (user != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext contect) => Unboarding()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff133c6d),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: _artboard == null
                  ? Container()
                  : Rive(
                      artboard: _artboard,
                      fit: BoxFit.cover,
                    ),
              width:
                  _size > 0 ? _size : MediaQuery.of(context).size.width * 0.8,
              height:
                  _size > 0 ? _size : MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 30),
                child: Text(
                  'Créer un compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    hintStyle: TextStyle(color: Colors.white)),
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  hintText: 'Mot de Passe',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintStyle: TextStyle(color: Colors.white)),
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                    onPressed: () {
                                      signUp();
                                    },
                                    child: Text(
                                      'Créer le compte',
                                      style: TextStyle(
                                        color: Color(0xff133c6d),
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color: Colors.white))),
                                    ),
                                  ),)
                        ],
                      ),
                    )))
          ],
        ));
  }
}
