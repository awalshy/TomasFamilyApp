import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/models/models/BlDev.dart';
import 'package:tomasfamilyapp/models/models/User.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';

AppState appReducer(AppState state, action) => AppState(
    userReducer(state.user, action),
    bldevsReducer(state.devs, action),
);

// User Reducer
final Reducer<UserModel> userReducer = combineReducers([
  TypedReducer<UserModel, UpdateUserAction>(_updateUser),
]);

UserModel _updateUser(UserModel user, dynamic action) => action.user;

// Conversations Reducer
final Reducer<List<Bldev>> bldevsReducer = combineReducers([
  TypedReducer<List<Bldev>, UpdateBlDevs>(_updateDevs),
]);

List<Bldev> _updateDevs(List<Bldev> devs, UpdateBlDevs action) => List.unmodifiable(List.from(action.devs));