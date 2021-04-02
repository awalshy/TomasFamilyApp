import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext contect) {
    return Column(
      children: <Widget>[
        Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/bg.png',
              ),
            ),
          ),
          height: 200.0,
        ),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.white,
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          height: 200,
          padding: EdgeInsets.all(20),
          child: Text('Bonjour Thomas !', style: TextStyle(
          color: Color(0xFF133C6D),
          fontSize: 36,
        ), textAlign: TextAlign.center,),
        )
      ]),
      Container(
        margin: const EdgeInsets.all(20),
        child: Row(
        children: [
          Text('Dernière Activité', style: TextStyle(
            color: Color(0xff133c6d),
            fontSize: 20
          ),)
        ],
      ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
        children: [
          Card(
            color: Color(0xff133c6d),
            child: Container(
              margin: const EdgeInsets.all(50),
              child: Text('Text', style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          Card(
            color: Color(0xff133c6d),
            child: Container(
              margin: const EdgeInsets.all(50),
              child: Text('Text', style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          Card(
            color: Color(0xff133c6d),
            child: Container(
              margin: const EdgeInsets.all(50),
              child: Text('Text', style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          Card(
            color: Color(0xff133c6d),
            child: Container(
              margin: const EdgeInsets.all(50),
              child: Text('Text', style: TextStyle(
                color: Colors.white
              ),),
            ),
          )
        ],
      ),
      ),
      Container(
        margin: const EdgeInsets.all(20),
        child: Row(children: [
          Text('Derniers Messages', style: TextStyle(
            color: Color(0xff133c6d),
            fontSize: 20
          ),)
        ],),
      ),
      Column(children: [
        Card(
          color: Color(0xff133c6d),
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Text', style: TextStyle(
                color: Colors.white
              ),),
          ),
        )
      ],)
      ],
    );
  }
}