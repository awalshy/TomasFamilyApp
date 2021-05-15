import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:tomasfamilyapp/constants.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:tomasfamilyapp/redux/store.dart';
import 'package:tomasfamilyapp/routes/routes.dart';

import 'package:tomasfamilyapp/screens/SplashScreen.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final store = createReduxStore();

  App();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      store.dispatch(LoadUser(user.uid));
      store.dispatch(LoadConversations(user.uid));
      store.dispatch(LoadGallery());
    }
    return StoreProvider<AppState>(store: store, child: MaterialApp(
      title: APP_NAME,
      initialRoute: '/',
      home: SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    ));
  }
}
