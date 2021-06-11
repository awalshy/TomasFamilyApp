import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rive/rive.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tomasfamilyapp/models/UserService.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';

import 'package:tomasfamilyapp/screens/Layout.dart';
import 'package:tomasfamilyapp/screens/Register.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final String animationPath = 'assets/tomas_logo.riv';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Artboard _artboard;
  double _size = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadRive();
    _loading = false;
    final keyboadController = KeyboardVisibilityController();
    keyboadController.onChange.listen((bool visible) {
      setState(() {
        _loading = false;
        _size = kIsWeb ? MediaQuery.of(context).size.height * 0.2 : MediaQuery.of(context).size.width * (visible ? 0.4 : 0.8);
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

  void signIn(Function(UserModel) dispatchSignIn) async {
    UserCredential user;
    setState(() {
      _loading = true;
    });
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (user != null) {
        DocumentSnapshot fireUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user.uid)
            .get();
        UserService _user = new UserService();
        _user.login(fireUser.get('firstName'),
            fireUser.get('lastName'), user.user.uid);
        setState(() {
          _loading = false;
        });
        dispatchSignIn(_user.get());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Layout()));
      }
    } on FirebaseAuthException catch (e) {
      var snack;
      if (e.code == 'user-not-found')
        snack = SnackBar(
          content: Text('Aucun compte trouvé avec cette adresse'),
        );
      if (e.code == 'wrong-password')
        snack = SnackBar(content: Text('Mauvais Mot De Passe'));
      if (snack != null) ScaffoldMessenger.of(context).showSnackBar(snack);
      setState(() {
        _loading = false;
      });
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
                kIsWeb ? MediaQuery.of(context).size.height * 0.4 : _size > 0 ? _size : MediaQuery.of(context).size.width * 0.8,
              height:
                kIsWeb ? MediaQuery.of(context).size.height * 0.4 : _size > 0 ? _size : MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
            ),
            Container(
              alignment: kIsWeb ? Alignment.center : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 30),
                child: Text(
                  'Se Connecter',
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
                    padding: EdgeInsets.symmetric(horizontal: kIsWeb ? MediaQuery.of(context).size.width * 0.2 : 20),
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
                              child: _loading
                                  ? CircularProgressIndicator()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                                            child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        SignUp()));
                                          },
                                          child: Text(
                                            'Créer un compte',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty.all(
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 20)),
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        side: BorderSide(
                                                            color: Colors.white))),
                                              )
                                        )),
                                        StoreConnector<AppState, dynamic Function(UserModel)>(
                                            converter: (store) {
                                              return (UserModel user) => store.dispatch(UpdateUserAction(user));
                                            },
                                            builder: (context, signInDispatch) {
                                              return ElevatedButton(
                                                onPressed: () {
                                                  signIn(signInDispatch);
                                                },
                                                child: Text(
                                                  'Se Connecter',
                                                  style: TextStyle(
                                                    color: Color(0xff133c6d),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty.all(
                                                      const EdgeInsets.symmetric(
                                                          vertical: 12,
                                                          horizontal: 20)),
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                          side: BorderSide(
                                                              color: Colors.white))),
                                                ),
                                              );
                                            },
                                        ),
                                      ],
                                    ))
                        ],
                      ),
                    )))
          ],
        ));
  }
}
