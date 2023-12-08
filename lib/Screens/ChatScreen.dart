import 'package:flutter/material.dart';
import 'package:trendhub/Screens/ChatScreen/chat.dart';
import 'package:trendhub/Screens/profile.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _index = 0;
  Widget page = UsersDisplay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account')
        ],
        currentIndex: _index,
        onTap: (int tappedIndex) {
          setState(() {
            _index = tappedIndex;
          });
          switch (_index) {
            case 0:
              setState(() {
                page = UsersDisplay();
              });
              break;
            case 1:
              setState(() {});
              break;
            case 2:
              setState(() {
                page = Profile();
              });
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
