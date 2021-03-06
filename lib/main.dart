import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tomasfamilyapp/app.dart';
import 'package:tomasfamilyapp/init/firebase.dart';
import 'package:tomasfamilyapp/init/flutter.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  initFlutter();
}

void main() async {
  runZonedGuarded(() async {
    await init();
    runApp(App());
  }, (error, stackTrace) {
    print('runZoneGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}