import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasfamilyapp/providers/ProfileProvider.dart';
import 'package:tomasfamilyapp/screens/Layout.dart';

class Unboarding extends StatefulWidget {
  Unboarding({Key key}) : super(key: key);

  @override
  _UnboardingState createState() => _UnboardingState();
}

class _UnboardingState extends State<Unboarding> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  FirebaseAuth _auth;

  void saveUserInfos() async {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    if (_formKey.currentState != null && _formKey.currentState.validate()) {
      final res = await profile.createAndSave(
          _firstNameController.text,
          _lastNameController.text,
          _familyController.text,
          _auth.currentUser.uid);
      if (res != 'error') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sauvegardé avec succès !')));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Layout()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff133c6d),
      appBar: AppBar(
        backgroundColor: Color(0xff133c6d),
        leading: Icon(Icons.arrow_back),
        title: SvgPicture.asset(
          'assets/images/LogoColorLight.svg',
          width: 150,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Text(
              'Compléter les informations du compte',
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Theme(
                  data: new ThemeData(primaryColor: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                              hintText: 'Prénom',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                              hintText: 'Nom de Famille',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom de famille';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: _familyController,
                          decoration: const InputDecoration(
                              hintText: 'CODE FAMILLE',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                          inputFormatters: [UpperCaseTextFormatter()],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre code famille';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              saveUserInfos();
                            },
                            child: Text('Sauvegarder',
                                style: TextStyle(
                                    color: Color(0xff133c6d), fontSize: 18)),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.white))),
                            ),
                          ))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
