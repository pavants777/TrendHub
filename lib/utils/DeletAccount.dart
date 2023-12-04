import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/functions/databasecollection.dart';

Widget DeletAccount(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            deletUser();
            Navigator.pushNamed(context, Routes.homepage);
          },
          child: Row(
            children: [
              Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Icon(Icons.delete_outline)),
              Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text('Delete Account')),
            ],
          ),
        ),
      )
    ],
  );
}
