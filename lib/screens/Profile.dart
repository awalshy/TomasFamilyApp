import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/screens/SignIn.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:tomasfamilyapp/redux/state.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _email;
  bool _edit = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _edit = false;
    setState(() {
      _edit = false;
    });
    _load();
  }

  void _load() async {
    final auth = FirebaseAuth.instance;
    setState(() {
      _email = auth.currentUser.email;
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => SignIn())));
  }

  @override
  Widget build(BuildContext context) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _edit ? 15 : 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_edit ? 'Editer' : 'Profile',
                                style: TextStyle(
                                    color: Color(0xFF133C6D),
                                    fontSize: _edit ? 26 : 36)),
                            StoreConnector<AppState, String>(converter: (store) => store.state.user.family,
                              builder: (context, family) {
                                return family != null &&
                                    family.isNotEmpty
                                    ? Text(
                                  'Famille: ' + family,
                                  style: TextStyle(color: Color(0xff133c6d)),
                                )
                                    : Row(
                                  children: [
                                    Text('Famille: ',
                                        style: TextStyle(color: Color(0xff133c6d))),
                                    SkeletonAnimation(
                                      shimmerColor: Color(0xff133c6d),
                                      borderRadius: BorderRadius.circular(20),
                                      shimmerDuration: 1000,
                                      child: Container(
                                        height: 8,
                                        width: MediaQuery.of(context).size.width *
                                            0.15,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.grey[200]),
                                      ),
                                    )
                                  ],
                                );
                              }
                            )
                            // Image.network(_user.imageProfil)
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/images/profile.svg',
                          width: MediaQuery.of(context).size.width *
                              (_edit ? 0.15 : 0.4),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: _edit ? 10 : 20,
                    thickness: 1.5,
                    color: Color(0xff133c6d),
                  ),
                  _edit
                      ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Theme(
                          data: new ThemeData(primaryColor: Color(0xff133c6d)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: const InputDecoration(
                                      hintText: 'Prénom',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff133c6d))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff133c6d))),
                                      hintStyle:
                                      TextStyle(color: Color(0xff133c6d))),
                                  style: TextStyle(color: Color(0xff133c6d)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: const InputDecoration(
                                      hintText: 'Nom de Famille',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff133c6d))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff133c6d))),
                                      hintStyle:
                                      TextStyle(color: Color(0xff133c6d))),
                                  style: TextStyle(color: Color(0xff133c6d)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff133c6d))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff133c6d))),
                                      hintStyle:
                                      TextStyle(color: Color(0xff133c6d))),
                                  style: TextStyle(color: Color(0xff133c6d)),
                                ),
                              ),
                            ],
                          )))
                      : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StoreConnector<AppState, UserModel>(converter: (store) => store.state.user,
                            builder: (context, user) {
                              return Text(user.firstName + ' ' + user.lastName,
                                  style: TextStyle(
                                      color: Color(0xff133c6d), fontSize: 28));
                            }
                          ),
                          _email != null
                              ? Text(_email,
                              style: TextStyle(
                                  color: Color(0xff133c6d), fontSize: 12))
                              : SkeletonAnimation(
                            shimmerColor: Color(0xff133c6d),
                            borderRadius: BorderRadius.circular(20),
                            shimmerDuration: 1000,
                            child: Container(
                              height: 10,
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200]),
                            ),
                          ),
                        ],
                      )),
                  _edit
                      ? Container()
                      : Divider(
                    height: 20,
                    thickness: 1.5,
                    color: Color(0xff133c6d),
                  ),
                  _edit
                      ? Row()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style:
                        TextStyle(color: Color(0xff133c6d), fontSize: 16),
                      ),
                      Switch(
                          value: false,
                          onChanged: (bool value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Not implemented')));
                          })
                    ],
                  ),
                  _edit
                      ? StoreConnector<AppState, UserModel>(converter: (store) => store.state.user,
                    builder: (context, user) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StoreConnector<AppState, Function(UserModel)>(
                              converter: (store) =>
                                  (UserModel user) =>
                                  store.dispatch(UpdateUserAction(user)),
                              builder: (context, save) =>
                                  ElevatedButton(
                                    onPressed: () {
                                      UserModel updatedUser = user;
                                      user.lastName = _lastNameController.text;
                                      user.firstName =
                                          _firstNameController.text;
                                      save(updatedUser);
                                      final auth = FirebaseAuth.instance;
                                      auth.currentUser.updateEmail(_email);
                                      setState(() {
                                        _email = _emailController.text;
                                        _edit = false;
                                      });
                                    },
                                    child: Text(
                                      'Sauvegarder',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 12)),
                                        backgroundColor:
                                        MaterialStateProperty.all(Color(
                                            0xff133c6d)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)))),
                                  ))
                        ],
                      );
                    }
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StoreConnector<AppState, UserModel>(
                          converter: (store) => store.state.user,
                        builder: (context, user) {
                            return ElevatedButton(
                              onPressed: () {
                                _firstNameController.text = user.firstName;
                                _lastNameController.text = user.lastName;
                                _emailController.text = _email;
                                setState(() {
                                  _edit = !_edit;
                                });
                              },
                              child: Text('Editer le profile'),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 12)),
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xff133c6d)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)))),
                            );
                        }
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signOut();
                          },
                          child: Text('Se Deconnecter'),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 12)),
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xff9e2020)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10))))),
                    ],
                  )
                ],
              ));
  }
}