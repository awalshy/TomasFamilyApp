import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:tomasfamilyapp/screens/Bluetooth.dart';
// Screens
import 'package:tomasfamilyapp/screens/Profile.dart';

class Layout extends StatefulWidget {
  Layout({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final widgets = [
    new Profile(),
    new Bluetooth()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bluetooth Test', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff133c6d),
        elevation: 5,
      ),
      body: Center(child: widgets.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF133C6D),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp),
              label: 'Profile',
              backgroundColor: const Color(0xFF133C6D)),
          BottomNavigationBarItem(icon: Icon(Icons.bluetooth), label: 'Bluetooth', backgroundColor: const Color(0xFF133c6d))
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
      floatingActionButton: _selectedIndex == 1 ? BlButton() : null,
    );
  }
}

class BlButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function()>(
      converter: (store) => () => store.dispatch(BlSearch()),
      builder: (context, search) {
        return FloatingActionButton.extended(
          onPressed: search,
          label: Text('Recherche'),
          icon: Icon(Icons.bluetooth_searching),
        );
      },
    );
  }
}
