import 'package:meta/meta.dart';
import 'package:tomasfamilyapp/constants.dart';

class UserModel {
  int id;
  String uid;
  String lastName;
  String firstName;
  String imageProfil;
  String family;

  UserModel(
      {@required this.uid,
      @required this.lastName,
      @required this.firstName,
      this.imageProfil});
  UserModel.empty();

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map[UserConstant.columnUid];
    lastName = map[UserConstant.columnLastName];
    firstName = map[UserConstant.columnFirstName];
    imageProfil = map[UserConstant.columnImageProfil];
    family = map[UserConstant.columnFamily];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      UserConstant.columnUid: uid,
      UserConstant.columnLastName: lastName,
      UserConstant.columnFirstName: firstName,
      UserConstant.columnImageProfil: imageProfil,
      UserConstant.columnFamily: family
    };
    return map;
  }
}
