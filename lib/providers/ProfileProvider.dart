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

  Future<bool> login() async {
    try {
      final uid =
          await _sharedPreferenceHelper.getString(UserConstant.columnUid);
      final firstName =
          await _sharedPreferenceHelper.getString(UserConstant.columnFirstName);
      final lastName =
          await _sharedPreferenceHelper.getString(UserConstant.columnLastName);
      final imageProfil = await _sharedPreferenceHelper
          .getString(UserConstant.columnImageProfil);

      _user = UserModel(
          uid: uid,
          lastName: lastName,
          firstName: firstName,
          imageProfil: imageProfil);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String uid) async {
    await _sharedPreferenceHelper.setString(UserConstant.columnUid, uid);
    final res = this.login();
    return res;
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
}
