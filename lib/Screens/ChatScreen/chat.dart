import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Models/ChatUser.dart';
import 'package:trendhub/Screens/ChatScreen/chatdetalis.dart';
import 'package:trendhub/functions/databasecollection.dart';

class UsersDisplay extends StatefulWidget {
  const UsersDisplay({Key? key}) : super(key: key);

  @override
  State<UsersDisplay> createState() => _UsersDisplayState();
}

class _UsersDisplayState extends State<UsersDisplay> {
  List<ChatUsers> users = [];
  String? userEmail;

  @override
  void initState() {
    super.initState();
    userEmail = FirebaseAuth.instance.currentUser!.email;
    listData();
  }

  listData() async {
    try {
      List<ChatUsers> fetchedUsers = await fetchData();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      print("Error fetching data: $e");
      // Handle the error accordingly (show a message, retry, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  const Text(
                    'Chats',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pink[50],
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                        onTap: () {
                          // Assuming "Pavan" is the default username for the new user message
                          createUserMessage(userEmail!, "Pavan");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            Text(
                              'New',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              enableSuggestions: false,
              decoration: InputDecoration(
                hintText: 'Search......',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.black,
                contentPadding: EdgeInsets.all(16),
                filled: true,
                fillColor: Colors.grey.shade100,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: UserChat(users[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
