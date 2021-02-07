import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart'; 

class BackendlessChat extends StatefulWidget {
  BackendlessChat({Key key, this.myLogin}) : super(key: key);

  final String myLogin;

  @override
  _BackendlessChatState createState() => _BackendlessChatState(myLogin: myLogin);
}

class _BackendlessChatState extends State<BackendlessChat> {
  _BackendlessChatState({this.myLogin}) : super();

  final String myLogin;

  String _messages = "";
  final myController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    initListeners();
  }

  void initListeners() async {
    Channel channel = await Backendless.messaging.subscribe("chat");
    channel.addMessageListener(onMessageReceived);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void onMessageSubmitted(String message) async {
    Backendless.messaging.publish(message, channelName: "chat", 
      publishOptions: PublishOptions()..headers = {"name": myLogin});
    myController.clear();
  }

  void onMessageReceived(PublishMessageInfo messageInfo) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(messageInfo.timestamp);
    var receivedMessage = "${time.hour}:${time.minute}:${time.second} ${messageInfo.headers['name']}: ${messageInfo.message}\n";
    setState(() => _messages += receivedMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myLogin),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft, 
            child: Text("$_messages")
          ),
          Align(
            alignment: Alignment.bottomLeft, 
            child: TextField(
              onSubmitted: onMessageSubmitted,
              controller: myController,
              decoration: InputDecoration(
                fillColor: Colors.black12, filled: true
              ),
            ),
          ),
        ],
      ),
    );
  }
}