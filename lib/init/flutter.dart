import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void initFlutter() {
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
