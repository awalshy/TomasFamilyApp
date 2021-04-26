import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomasfamilyapp/models/models/Message.dart';

class MessagesService {
  FirebaseFirestore _firestore;

  MessagesService() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<List<MessageModel>> loadMessages(String convId) async {
    DocumentReference _conv = _firestore.collection('conversations').doc(convId);
    QuerySnapshot messs = await _firestore.collection('messages').where('conversation', isEqualTo: _conv).limit(30).get();
    List<MessageModel> messages = messs.docs.map<MessageModel>((m) {
      final Timestamp createdDate = m.get('createdAt');
      return new MessageModel(
        content: m.get('content'),
        createdAt: createdDate.toDate(),
        conversation: m.get('conversation'),
        sender: m.get('sender')
      );
    }).toList();
    messages.sort((a,b) => a.createdAt.compareTo(b.createdAt));
    return messages;
  }

  Future<void> sendMessage(MessageModel msg) async {
    try {
      _firestore.collection('messages').add({
        'createdAt': msg.createdAt,
        'conversation': msg.conversation,
        'sender': msg.sender,
        'content': msg.content
      });
      DocumentSnapshot msgCountSnap = await msg.conversation.get();
      await msg.conversation.update({
        'msgCount': msgCountSnap.get('msgCount') + 1
      });
      // Notify User
    } catch (e) {
      print('Failed to send' + e.message);
    }
  }
}