import 'package:flutter/material.dart';
import 'package:tomasfamilyapp/screens/Gallery.dart';
import 'package:tomasfamilyapp/screens/Home.dart';
import 'package:tomasfamilyapp/screens/Messages.dart';
import 'package:tomasfamilyapp/screens/Phone.dart';
import 'package:tomasfamilyapp/screens/Profile.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              child: Image.asset('assets/images/TomasLogoDark.png', width: 150,),
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
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
