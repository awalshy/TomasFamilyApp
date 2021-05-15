import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/convs.svg'
                  , width: 120, height: 120,
                ),
                StoreConnector<AppState, String>(builder: (context, firstname) => Text('Hello ' + firstname + '!', style: TextStyle(color: Color(0xff133c6d), fontSize: 26),), converter: (store) => store.state.user.firstName)
              ],
            ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
              'Conversations',
              style: TextStyle(fontSize: 24
                  , color: Color(0xff133c6d))
          ),
        ),
        StoreConnector<AppState, Function()>(
            converter: (store) {
              final uid = store.state.user.uid;
              return () => store.dispatch(LoadConversations(uid));
            },
          builder: (context, refresh) {
              return ElevatedButton(
                onPressed: refresh,
                child: Text('Refresh'),
              );
          },
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
        )],
        );
      },
    );
  }
}