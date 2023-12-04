import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';

Widget LogOut(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, Routes.homepage);
          },
          child: Row(
            children: [
              Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Icon(Icons.logout)),
              Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text('LogOut')),
            ],
          ),
        ),
      )
    ],
  );
}
