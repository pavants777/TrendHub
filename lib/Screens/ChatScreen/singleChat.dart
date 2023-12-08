import 'package:flutter/material.dart';
import 'package:trendhub/Models/ChatUser.dart';

class ChatUserD extends StatefulWidget {
  ChatUsers? user;
  ChatUserD({this.user});

  @override
  State<ChatUserD> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUserD> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
      elevation: 200,
      title: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: Row(children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: ScreenWidth * 0.06,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 0, left: 35),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 5,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: ScreenWidth * 0.04,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.user!.userName}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '  Online',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.green.shade500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ]),
      ),
    ));
  }
}
