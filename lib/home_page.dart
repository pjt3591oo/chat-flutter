import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:chat/chat_message.dart';
import 'dart:math';

var _logger = Logger();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  List<Chat> _chats = [];
  String _prevId = "멍개";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
        ? CupertinoNavigationBar(middle: Text("Chat App"))
        : AppBar(
            title: Text("Chat App"),
        ),
      body: Column(
        children: <Widget> [
          Expanded(
            child: AnimatedList(
              key: _animListKey,
              itemBuilder: getChat, 
              reverse: true,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Message Input"),
                    controller: _textEditingController,
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                SizedBox(width: 8),
                Platform.isIOS
                  ? CupertinoButton(
                      child: Icon(Icons.send), 
                      onPressed: () {
                        _handleSubmitted(_textEditingController.text);
                      }
                    )
                  :TextButton(
                      child: Text("Send"),
                      onPressed: () {
                        _handleSubmitted(_textEditingController.text);
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.amberAccent,
                      )
                    )
              ]
            ),
          )
        ]
      )
    );
  }

  Widget getChat(context, index, animation) {
    Chat chat = _chats[index];
    bool isShowDt = true;
    String id = chat.id;
    String text = chat.text;
    String dt = chat.dt;

    if (index > 0 &&  _chats[index-1].id == chat.id && _chats[index-1].dt == chat.dt) {
      isShowDt = false;
    }
    _logger.d('index: $index, isShowDt: $isShowDt, id: $id, text: $text, dt: $dt');
    _logger.d('animation: $animation');

    if(chat.isMe) {
      return ChatMessaageSend(
        animation: animation,
        text: chat.text,
        id: chat.id,
        dt: chat.dt,
        isShowDt: isShowDt,
      );
    } else {
      return ChatMessaageReceive(
        animation: animation,
        text: chat.text,
        id: chat.id,
        dt: chat.dt,
        isShowDt: isShowDt,
      );
    }
  }

  void _handleSubmitted(String text) {
    if (text.length == 0) return;

    _textEditingController.clear();
    String dt = DateFormat.jm().format(DateTime.now());
    // bool isShowDt = _chats.length != 0 && _chats[0].dt == dt ? false : true;
    int n = Random().nextInt(3) + 1;
    String id = _prevId + n.toString();
    bool isMe = id == _prevId +'1';

    Chat chat = Chat(id: id, text: text, dt: dt, isShowDt: true, isMe: isMe) ;

    _chats.insert(0, chat);
    // setState(() {
    //   _chats.insert(0, chat);
    // });
    _animListKey.currentState.insertItem(0);
  }
  
}