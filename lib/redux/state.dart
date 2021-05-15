import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/models/models/Image.dart';
import 'package:tomasfamilyapp/models/models/User.dart';

class AppState {
  final UserModel user;
  final List<ConversationModel> convs;
  final List<ImageModel> imgs;

  AppState(this.user, this.convs, this.imgs);

  factory AppState.initial() => AppState(null, List.unmodifiable([]), List.unmodifiable([]));
}