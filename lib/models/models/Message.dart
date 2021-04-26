import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final DocumentReference sender;
  final DocumentReference conversation;
  final String content;
  final DateTime createdAt;

  MessageModel({
    this.content,
    this.conversation,
    this.sender,
    this.createdAt
  });
}