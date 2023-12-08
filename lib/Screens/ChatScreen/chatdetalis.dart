import 'package:flutter/material.dart';
import 'package:trendhub/Models/ChatUser.dart';
import 'package:trendhub/Screens/ChatScreen/singleChat.dart';

class UserChat extends StatefulWidget {
  final ChatUsers? user;
  UserChat(this.user);

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    final srceenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatUserD(user: widget.user!)));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    maxRadius: srceenWidth * 0.08,
                    // backgroundImage: NetworkImage(widget.user!.thumbnail),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 0, left: 45),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: srceenWidth * 0.05,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.user!.userName}',
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Last Message at End',
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
              Text('06 DEC',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
            ]),
          ),
        ),
      ],
    );
  }
}
