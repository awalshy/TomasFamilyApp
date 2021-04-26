import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';

void loadContactsMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LoadContacts) {

  }
  next(action);
}