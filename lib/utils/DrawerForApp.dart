import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Models/UserModels.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/utils/Setting.dart';
import 'package:trendhub/utils/companyName.dart';
import 'package:trendhub/utils/logout.dart';

class DrawerForApp extends StatefulWidget {
  UserModel? user;

  DrawerForApp({this.user});

  @override
  State<DrawerForApp> createState() => _DrawerForAppState();
}

class _DrawerForAppState extends State<DrawerForApp> {
  getuser() async {
    if (widget.user != null) {
      widget.user!.userEmail = FirebaseAuth.instance.currentUser?.email;
      print(widget.user!.userEmail);

      try {
        var docRef = await FirebaseFirestore.instance
            .collection('Accounts')
            .doc(widget.user!.userEmail)
            .get();

        print('Document data: ${docRef.data()}');

        if (docRef.exists) {
          widget.user!.userName = docRef.data()?['userName']?.toString();
          print('User Name: ${widget.user!.userName}');
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('userNOt Founded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(padding: EdgeInsets.all(0), child: CompanyName()),
            ExpansionTile(
              childrenPadding: EdgeInsets.all(20),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${widget.user!.userName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              children: [
                Text('Email :'),
                Text('${widget.user!.userEmail}'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ;
                    },
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Icon(Icons.home)),
                        Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Text('Home')),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Icon(Icons.payment)),
                        Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Text('Payment')),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            SettingsScreen(context),
            SizedBox(
              height: 40,
            ),
            LogOut(context),
          ]),
    );
  }
}
