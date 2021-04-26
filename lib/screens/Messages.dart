import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:tomasfamilyapp/screens/Conversation.dart';

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<ConversationModel>>(
      converter: (store) => store.state.convs,
      builder: (context, conversations) {
        return Column(
          children: [
          SvgPicture.asset('assets/images/convs.svg'
        , width: 120, height: 120,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
              'Conversations',
              style: TextStyle(fontSize: 28, color: Color(0xff133c6d))
          ),
        ),
        Divider(
          height: 15,
        ),
        SingleChildScrollView(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: conversations.length,
            itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xff133c6d),
                  child: Text(conversations[index].name[0]),
                ),
                title: Text(conversations[index].name),
                subtitle: Text('Le dernier message'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new Conversation(conv: conversations[index])));
                },
            ),
          ),
        )
        ],
          );
      },
    );
  }
}