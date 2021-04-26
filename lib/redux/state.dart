import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/models/models/User.dart';

class AppState {
  final UserModel user;
  final List<ConversationModel> convs;

  AppState(this.user, this.convs);

  factory AppState.initial() => AppState(null, List.unmodifiable([]));
}