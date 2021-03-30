import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:tomasfamilyapp/constants.dart';
import 'package:tomasfamilyapp/routes/routes.dart';

import 'package:tomasfamilyapp/screens/SplashScreen.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      initialRoute: '/',
      home: SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}
