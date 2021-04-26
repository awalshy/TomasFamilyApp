
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
      String firstName, String lastName, String family, String uid
      ) async {
    this._user = UserModel(uid: uid, lastName: lastName, firstName: firstName);
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
        return null;
      else {
        members.add(user);
        DocumentReference famDoc =
        _firestore.collection('families').doc(famille.id);
        await famDoc.update({'members': members});
      }
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
      DocumentReference fam = userDoc.get('family');
      DocumentSnapshot familyDoc = await fam.get();
      final family = familyDoc.get('name');
      base = new UserModel(uid: id, lastName: lastName, firstName: firstName, family: family);
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
      String firstName, String lastName, String familyCode, String uid
      ) async {
    try {
      _user = UserModel(uid: uid,
          lastName: lastName,
          firstName: firstName,
          family: familyCode);
      return true;
    } catch(e) {
      return false;
    }
  }
}