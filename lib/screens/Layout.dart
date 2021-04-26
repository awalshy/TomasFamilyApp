import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:tomasfamilyapp/redux/state.dart';
// Screens
import 'package:tomasfamilyapp/screens/Gallery.dart';
import 'package:tomasfamilyapp/screens/Home.dart';
import 'package:tomasfamilyapp/screens/Messages.dart';
import 'package:tomasfamilyapp/screens/Phone.dart';
import 'package:tomasfamilyapp/screens/Profile.dart';

class Layout extends StatefulWidget {
  Layout({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final widgets = [
    new Profile(),
    new Message(),
    new Home(),
    new Phone(),
    new Gallery()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/images/LogoColorDark.svg',
                width: 150,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(child: widgets.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF133C6D),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp),
              label: 'Profile',
              backgroundColor: const Color(0xFF133C6D)),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger),
              label: 'Messagerie',
              backgroundColor: const Color(0xFF133C6D)),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
              backgroundColor: const Color(0xFF133C6D)),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: 'Appels',
              backgroundColor: const Color(0xFF133C6D)),
          BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Gallerie',
              backgroundColor: const Color(0xFF133C6D))
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
      endDrawer: new StoreConnector<AppState, DevToolsStore<AppState>>(
          converter: (store) => store,
        builder: (context, store) {
            return ReduxDevTools<AppState>(store);
        },
      ),
    );
  }
}
