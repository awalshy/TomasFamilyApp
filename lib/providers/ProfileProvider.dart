import 'package:flutter/material.dart';
import 'package:tomasfamilyapp/helpers/sharedPreferences.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/constants.dart';

class ProfileProvider extends ChangeNotifier {
  SharedPreferenceHelper _sharedPreferenceHelper;
  UserModel _user;

  ProfileProvider() {
    _sharedPreferenceHelper = SharedPreferenceHelper();
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
}
