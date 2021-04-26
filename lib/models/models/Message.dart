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
}