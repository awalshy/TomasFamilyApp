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
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final widgets = [
    new Profile(),
    new Message(),
    // new Home(),
    new Phone(),
    new Gallery()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
              child: SvgPicture.asset(
                'assets/images/LogoColorDark.svg',
                width: 150,
              ),
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
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.home),
          //     label: 'Accueil',
          //     backgroundColor: const Color(0xFF133C6D)),
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
      floatingActionButton: _selectedIndex != 1 ? null : FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              elevation: 10,
              enableDrag: true,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              builder: (context) {
                return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, bottom: 40),
                        child: Text('Commencer une conversation', style: TextStyle(color: Color(0xff133c6d), fontSize: 24),),
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Nom de la conversation',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Color(0x133c6d)))
                        ),
                      ),
                      ListTile(
                        leading: Radio(value: false, onChanged: (value) {}),
                        title: Text('Contact 1'),
                      ),
                      ListTile(
                        leading: Radio(value: false, onChanged: (value) {}),
                        title: Text('Contact 2'),
                      ),
                      ListTile(
                        leading: Radio(value: false, onChanged: (value) {}),
                        title: Text('Contact 3'),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(child: Text('Créer'),),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xff133c6d)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          ),
                        )
                      )
                    ],
                  )
                );
          });
        },
        label: Text('Nouvelle'),
        icon: Icon(Icons.messenger_outlined),
        backgroundColor: Color(0xff133c6d),
      ),
    );
  }
}
