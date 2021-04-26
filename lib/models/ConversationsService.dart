import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/models/models/Message.dart';

class ConversationsService {
  List<ConversationModel> _convs;
  FirebaseFirestore _firestore;

  ConversationsService({
    List<ConversationModel> convs
  }) {
    this._convs = convs;
    this._firestore = FirebaseFirestore.instance;
  }

  Future<ConversationModel> create(
      String myUid, List<dynamic> members, String name
      ) async {
    try {
      // Check if conversation exists
      QuerySnapshot conv = await _firestore
          .collection('conversations')
          .where('name', isEqualTo: name)
          .where('members', arrayContains: members)
          .limit(1)
          .get();
      if (conv.size > 0) return null;
      // if not create a conversation
      DocumentReference conversation = await _firestore
          .collection('conversations')
          .add({'members': members, 'lastRead': DateTime.now(), 'name': name});
      ConversationModel _conv = new ConversationModel(
          name: name, members: members, lastRead: DateTime.now());
      return _conv;
    } on FirebaseException catch(e) {
      print('CONV CREATION ERROR' + e.message);
    }
    return null;
  }

  Future<List<ConversationModel>> loadConversations(
      String uid
      ) async {
    try {
      DocumentReference _user = _firestore.collection('users').doc(uid);
      QuerySnapshot convs = await _firestore
          .collection('conversations')
          .where('members', arrayContains: _user).get();
      List<ConversationModel> _cs = convs.docs.map<ConversationModel>((doc) {
        final Timestamp lastRead = doc.get('lastRead');
        return new ConversationModel(
          name: doc.get('name'),
          lastRead: lastRead.toDate(),
          members: doc.get('members'),
          id: doc.id
        );
      }).toList();
      return _cs;
    } on FirebaseException catch(e) {
      print('Error loading conversations ' + e.message);
    }
    return null;
  }
}