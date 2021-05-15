import 'package:flutter/cupertino.dart';
import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/models/models/Image.dart';
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

// Contacts Actions
class LoadContacts {
  LoadContacts();
}

// Conversation Actions
class LoadConversations {
  final String uid;
  LoadConversations(this.uid);
}

class RemoveConversationAction {
  final ConversationModel conv;

  RemoveConversationAction(this.conv);
}
class AddConversationAction {
  final ConversationModel conv;

  AddConversationAction(this.conv);
}
class UpdateConversationAction {
  final List<ConversationModel> convs;

  UpdateConversationAction(this.convs);
}

// Gallery Actions
class LoadGallery {
  LoadGallery();
}

class UploadImage {
  String path;

  UploadImage(this.path);
}

class UpdateGallery {
  List<ImageModel> imgs;

  UpdateGallery(this.imgs);
}

class AddImage {
  ImageModel img;

  AddImage(this.img);
}