import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/models/ConversationsService.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:tomasfamilyapp/redux/actions.dart';

void loadConversationsMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LoadConversations) {
    ConversationsService convServ = new ConversationsService();
    convServ.loadConversations(action.uid)
      .then((convs) => store.dispatch(UpdateConversationAction(convs)));
  }
  next(action);
}