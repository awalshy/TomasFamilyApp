import 'package:meta/meta.dart';

class MessageModel {
  final String documentId;
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  final int type;
  final bool readByPeer;

  MessageModel({
    this.documentId,
    @required this.idFrom,
    @required this.idTo,
    @required this.timestamp,
    @required this.content,
    @required this.type,
    @required this.readByPeer
  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String documentId) {
    return MessageModel(
      documentId: documentId,
      idFrom: map["idFrom"],
      idTo: map["idTo"],
      timestamp: map["timestamp"],
      content: map["content"],
      type: map["type"],
      readByPeer: map["readByPeer"]
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "idFrom": idFrom,
      "idTo": idTo,
      "timestamp": timestamp,
      "content": content,
      "type": type,
      "readByPeer": readByPeer,
    };
    return map;
  }
}