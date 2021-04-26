import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasfamilyapp/models/MessagesService.dart';
import 'package:tomasfamilyapp/models/models/Conversation.dart';
import 'package:tomasfamilyapp/models/models/Message.dart';

class Conversation extends StatefulWidget {
  Conversation({Key key, ConversationModel conv}): super(key: key) {
   this.conv = conv;
  }
  ConversationModel conv;

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final GlobalKey<ScaffoldState> _scaffKey = new GlobalKey<ScaffoldState>();
  bool _loaded = false;
  List<MessageModel> messages = List.from([]);
  DocumentReference user;
  DocumentReference conversation;
  TextEditingController _message = TextEditingController();
  MessagesService messServ;

  @override
  void initState() {
    super.initState();
    messServ = new MessagesService();
    _loadConversation();
    user = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid);
    conversation = FirebaseFirestore.instance.collection('conversations').doc(widget.conv.id);
    FirebaseFirestore.instance.collection('conversations').doc(widget.conv.id).snapshots().listen((event) {
      _loadConversation();
    });
  }

  Future<void> _loadConversation() async {
    final m = await messServ.loadMessages(widget.conv.id);
    setState(() {
      messages = m;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xff133c6d),
        ),
        title: Text(widget.conv.name, style: TextStyle(color: Color(0xff133c6d)),),
        backgroundColor: Colors.white,
        elevation: 6,
        actions: [
          IconButton(icon: Icon(Icons.more_vert_outlined, color: Color(0xff133c6d),), onPressed: () {
            _scaffKey.currentState.openEndDrawer();
          })
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(widget.conv.name, style: TextStyle(fontSize: 26, color: Colors.white),),
              decoration: BoxDecoration(
                color: Color(0xff133c6d)
              ),
            ),
            ListTile(
              title: Text('Membres ${widget.conv.members.length}'),
            ),
            Divider(height: 10,)
          ],
        ),
      ),
      body: !_loaded ? Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff133c6d)),
      )) : SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final bool me = messages[index].sender == user;
                    return Bubble(
                      margin: BubbleEdges.only(top: 12),
                      elevation: 6,
                      padding: BubbleEdges.symmetric(vertical: 10, horizontal: 15),
                      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
                      color: me ? Color(0xff133c6d) : Colors.white,
                      child: Text(messages[index].content,
                        textAlign: me ? TextAlign.right : TextAlign.left,
                        style: TextStyle(color: me ? Colors.white : Colors.black),
                      ),
                      nip: me ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                    );
                  }
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Row(
            children: [
              Flexible(child: TextField(
                controller: _message,
                decoration: const InputDecoration(
                    hintText: 'Message',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Color(0xff133c6d))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Color(0xff133c6d))),
                    hintStyle:
                    TextStyle(color: Color(0xff133c6d))),
                style: TextStyle(color: Color(0xff133c6d)),
              )),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  messServ.sendMessage(new MessageModel(
                     sender: user,
                     conversation: conversation,
                     createdAt: DateTime.now(),
                     content: _message.text
                  ));
                  _message.text = '';
                },
              )
            ],
          )),
    );
  }
}