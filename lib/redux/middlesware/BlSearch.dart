import 'package:tomasfamilyapp/models/models/BlDev.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:flutter_blue/flutter_blue.dart';

void blSearchMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is BlSearch) {
    print('Searching...');
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 5));

    flutterBlue.scanResults.listen((results) {
      List<Bldev> devs = [];
      print('### Update Results');
      for (ScanResult r in results) {
        final name = r.device.name != null ? r.device.name : r.device.id;
        final d = Bldev(name, r.rssi.toString());
        print('Found ${d.name} | ${d.rssi}');
        if (d.name != null && d.name != ' ' && d.name != '') devs.add(d);
      }
      store.dispatch(UpdateBlDevs(devs));
    });
    // flutterBlue.stopScan();
  }
  next(action);
}
