import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tomasfamilyapp/models/models/User.dart';

class UserService {
  UserModel _user;
  FirebaseFirestore _firestore;

  UserService({
    UserModel user
  }) {
    this._user = user;
    this._firestore = FirebaseFirestore.instance;
  }

  bool exists() => _user != null;

  UserModel get() => _user;

  Future<UserModel> create(
      String firstName, String lastName, String uid
      ) async {
    this._user = UserModel(uid: uid, lastName: lastName, firstName: firstName);
    CollectionReference usersCollection = _firestore.collection('users');
    // Create User In DB
    try {
      var user = usersCollection.doc(uid);
      await user.set({
        'createdAt': Timestamp.now(),
        'firstName': _user.firstName,
        'lastName': _user.lastName,
        'uid': uid
      });
    } catch (e) {
      return null;
    }
    return this._user;
  }

  Future<UserModel> load(String uid) async {
    UserModel base;
    try {
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      DocumentSnapshot userDoc = await userRef.get();
      final lastName = userDoc.get('lastName');
      final firstName = userDoc.get('firstName');
      final id = uid;
      base = new UserModel(uid: id, lastName: lastName, firstName: firstName);
      return base;
    } on FirebaseException catch(e) {
      print('Failed to load user' + e.message);
    }
    return null;
  }

  Future<UserModel> update(
      String firstName, String lastName, String email
      ) async {
    String uid = _user.uid;
    UserModel _base = _user;
    try {
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      await userRef.update({
        'firstName': firstName,
        'lastName': lastName
      });
      final fireAuth = FirebaseAuth.instanceFor(app: _firestore.app);
      fireAuth.currentUser.updateEmail(email);
      _user.firstName = firstName;
      _user.lastName = lastName;
    } on FirebaseException catch(e) {
      print('Failed to Update User:' + e.message);
      return _base;
    }
    return _user;
  }

  Future<bool> login(
      String firstName, String lastName, String uid
      ) async {
    try {
      _user = UserModel(uid: uid,
          lastName: lastName,
          firstName: firstName);
      return true;
    } catch(e) {
      return false;
    }
  }
}