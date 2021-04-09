import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/providers/ProfileProvider.dart';
import 'package:tomasfamilyapp/screens/SignIn.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel _user;
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
    _loadUser();
  }

  void _loadUser() async {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final auth = FirebaseAuth.instance;
    setState(() {
      _user = profile.user;
      _email = auth.currentUser.email;
    });
  }

  void _save() {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    profile.update(_firstNameController.text, _lastNameController.text,
        _emailController.text);
    var user = _user;
    user.lastName = _lastNameController.text;
    user.firstName = _firstNameController.text;
    _email = _emailController.text;
    setState(() {
      _edit = !_edit;
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext contect) => SignIn())));
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
                      _user != null &&
                              _user.family != null &&
                              _user.family.isNotEmpty
                          ? Text(
                              'Famille: ' + _user.family,
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
                        _user != null
                            ? Text(_user.firstName + ' ' + _user.lastName,
                                style: TextStyle(
                                    color: Color(0xff133c6d), fontSize: 28))
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SkeletonAnimation(
                                  shimmerColor: Color(0xff133c6d),
                                  borderRadius: BorderRadius.circular(20),
                                  shimmerDuration: 1000,
                                  child: Container(
                                    height: 14,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200]),
                                  ),
                                ),
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
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _save();
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
                                MaterialStateProperty.all(Color(0xff133c6d)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _firstNameController.text = _user.firstName;
                          _lastNameController.text = _user.lastName;
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
