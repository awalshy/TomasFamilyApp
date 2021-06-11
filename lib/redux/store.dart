import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:tomasfamilyapp/redux/middlesware/BlSearch.dart';
import 'package:tomasfamilyapp/redux/middlesware/loadUser.dart';
import 'package:tomasfamilyapp/redux/reducers.dart';
import 'package:tomasfamilyapp/redux/state.dart';

DevToolsStore<AppState> createReduxStore() {
  return DevToolsStore<AppState>(
      appReducer,
      initialState: AppState.initial(),
    middleware: [
      loadUserMiddleware,
      blSearchMiddleware
    ]
  );
}