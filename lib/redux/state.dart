import 'package:tomasfamilyapp/models/models/BlDev.dart';
import 'package:tomasfamilyapp/models/models/User.dart';

class AppState {
  final UserModel user;
  final List<Bldev> devs;

  AppState(this.user, this.devs);

  factory AppState.initial() => AppState(null, List.unmodifiable([]));
}