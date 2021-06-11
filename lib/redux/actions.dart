import 'package:flutter/cupertino.dart';
import 'package:tomasfamilyapp/models/models/BlDev.dart';
import 'package:tomasfamilyapp/models/models/User.dart';

// User Actions
class UpdateUserAction {
  final UserModel user;

  UpdateUserAction(this.user);
}

class LoadUser {
  final String id;
  LoadUser(this.id);
}

// Bluetooth Actions
class BlSearch {
  BlSearch();
}

class UpdateBlDevs {
  List<Bldev> devs;

  UpdateBlDevs(this.devs);
}
