import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tomasfamilyapp/helpers/sharedPreferences.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileProvider extends ChangeNotifier {
  SharedPreferenceHelper _sharedPreferenceHelper;
  UserModel _user;
  FirebaseFirestore _firestore;

  ProfileProvider() {
    _sharedPreferenceHelper = SharedPreferenceHelper();
    _firestore = FirebaseFirestore.instance;
  }

  UserModel get user => _user;

  void setUid(String value) {
    _user.uid = value;
    _sharedPreferenceHelper
        .setString(UserConstant.columnUid, value)
        .then((value) => notifyListeners());
  }

  void setLastName(String value) {
    _user.lastName = value;
    _sharedPreferenceHelper
        .setString(UserConstant.columnLastName, value)
        .then((value) => notifyListeners());
  }

  void setFirstName(String value) {
    _user.firstName = value;
    _sharedPreferenceHelper
        .setString(UserConstant.columnFirstName, value)
        .then((value) => notifyListeners());
  }

  void setImageProfil(String value) {
    _user.imageProfil = value;
    _sharedPreferenceHelper
        .setString(UserConstant.columnImageProfil, value)
        .then((value) => notifyListeners());
  }

  void setFamily(String value) {
    _user.family = value;
    _sharedPreferenceHelper
        .setString(UserConstant.columnFamily, value)
        .then((value) => notifyListeners());
  }

  Future<bool> isLogged() async {
    if (await _sharedPreferenceHelper.getString(UserConstant.columnUid) == "")
      return false;
    else
      return true;
  }

  Future<bool> login(
      String firstName, String lastName, String familyCode, String uid) async {
    try {
      _user = UserModel(
          uid: uid,
          family: familyCode,
          lastName: lastName,
          firstName: firstName);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> createAndSave(
      String firstName, String lastName, String family, String uid) async {
    _user = UserModel(uid: uid, lastName: lastName, firstName: firstName);
    CollectionReference usersCollection = _firestore.collection('users');
    QuerySnapshot fam = await _firestore
        .collection('families')
        .where('name', isEqualTo: family)
        .limit(1)
        .get();
    QueryDocumentSnapshot famille = fam.docs.first;
    List<dynamic> members = famille.get('members');

    // Create User In DB
    try {
      var user = usersCollection.doc(uid);
      await user.set({
        'createdAt': Timestamp.now(),
        'firstName': _user.firstName,
        'lastName': _user.lastName,
        'family': _user.family,
        'uid': uid
      });
      if (members.contains(uid))
        return 'error';
      else {
        members.add(user);
        DocumentReference famDoc =
            _firestore.collection('families').doc(famille.id);
        await famDoc.update({'members': members});
      }
    } catch (e) {
      return 'error';
    }
    return 'created';
  }

  Future<bool> update(String firstName, String lastName, String email) async {
    String uid = _user.uid;
    try {
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      await userRef.update({
        'firstName': firstName,
        'lastName': lastName,
      });
      final fireAuth = FirebaseAuth.instanceFor(app: _firestore.app);
      fireAuth.currentUser.updateEmail(email);
      _user.firstName = firstName;
      _user.lastName = lastName;
    } on FirebaseException catch (e) {
      return false;
    }
    return true;
  }
}
