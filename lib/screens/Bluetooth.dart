import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tomasfamilyapp/models/models/BlDev.dart';
import 'package:tomasfamilyapp/redux/state.dart';

class Bluetooth extends StatefulWidget {
  Bluetooth({Key key}) : super(key: key);

  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Bldev>>(
        converter: (store) => store.state.devs,
        builder: (context, devs) {
          if (devs.isEmpty) return Text('No Devices');
          print('Dev count: ${devs.length}');
          return ListView.builder(
              itemCount: devs.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(devs[index].name),
                  subtitle: Text(devs[index].rssi),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xff133c6d),
                    child: Text(devs[index].name[0]),
                  )));
        });
  }
}
