import 'package:tomasfamilyapp/models/UserService.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/redux/state.dart';


void loadUserMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LoadUser) {
    UserService _user = new UserService();
    _user.load(action.id)
        .then((UserModel user) => store.dispatch(UpdateUserAction(user)));
  }
  next(action);
}