import 'package:flutter/material.dart';

class Chat {
  final String text;
  final String id;
  final String dt;
  final bool isShowDt;
  final bool isMe;

  const Chat({Key key, this.text, this.id, this.dt, this.isShowDt, this.isMe});
}

class ChatMessaageReceive extends StatelessWidget {
  final String text;
  final String id;
  final String dt;
  final bool isShowDt;

  const ChatMessaageReceive({Key key, this.text, this.id, this.dt, this.isShowDt}): super(key: key);

  @override
  Widget build(BuildContext context ){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            height: 36,
            width: 30,
            child: Image.asset('assets/images/frog.png')
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      id,
                      style: TextStyle (fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      dt,
                      style: TextStyle (
                        color: isShowDt
                          ? Colors.black.withOpacity(0.4) 
                          : Colors.black.withOpacity(0) 
                      ),
                    ),
                  ],
                ),
                Container (
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black87,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

class ChatMessaageSend extends StatelessWidget {
  final String text;
  final String id;
  final String dt;
  final bool isShowDt;

  const ChatMessaageSend({Key key, this.text, this.id, this.dt, this.isShowDt}): super(key: key);

  @override
  Widget build(BuildContext context ){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  dt,
                  style: TextStyle (
                    color: isShowDt
                      ? Colors.black.withOpacity(0.4) 
                      : Colors.black.withOpacity(0) 
                  ),
                ),
                SizedBox(width: 8),
                Container (
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black87,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
        ],
      )
    );
  }
}