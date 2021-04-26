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

// Conversation Actions
class RemoveConversationAction {
  final String id;

  RemoveConversationAction(this.id);
}
class AddConversationAction {
  final String id;

  AddConversationAction(this.id);
}
class UpdateConversationAction {
  final List<String> ids;

  UpdateConversationAction(this.ids);
}