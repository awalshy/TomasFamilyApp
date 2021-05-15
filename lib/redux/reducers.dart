import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/models/models/Image.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';

AppState appReducer(AppState state, action) => AppState(
    userReducer(state.user, action),
    conversationReducer(state.convs, action),
    galleryReducer(state.imgs, action)
);

// User Reducer
final Reducer<UserModel> userReducer = combineReducers([
  TypedReducer<UserModel, UpdateUserAction>(_updateUser),
]);

UserModel _updateUser(UserModel user, dynamic action) => action.user;

// Conversations Reducer
final Reducer<List<ConversationModel>> conversationReducer = combineReducers([
  TypedReducer<List<ConversationModel>, RemoveConversationAction>(_removeConv),
  TypedReducer<List<ConversationModel>, AddConversationAction>(_addConv),
  TypedReducer<List<ConversationModel>, UpdateConversationAction>(_updateConvs),
]);

List<ConversationModel> _removeConv(List<ConversationModel> convs, RemoveConversationAction action) => List.unmodifiable(List.from(convs)..remove(action.conv));
List<ConversationModel> _addConv(List<ConversationModel> convs, AddConversationAction action) => List.unmodifiable(List.from(convs)..add(action.conv));
List<ConversationModel> _updateConvs(List<ConversationModel> convs, UpdateConversationAction action) => List.unmodifiable(List.from(action.convs));

// Gallery Reducer
final Reducer<List<ImageModel>> galleryReducer = combineReducers([
  TypedReducer<List<ImageModel>, UpdateGallery>(_updateImages),
]);

List<ImageModel> _updateImages(List<ImageModel> imgs, UpdateGallery action) => List.unmodifiable(List.from(action.imgs));