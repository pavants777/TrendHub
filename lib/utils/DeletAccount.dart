import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/functions/databasecollection.dart';

Widget DeletAccount(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Use Colors.red directly
            ),
            onPressed: () {
              deletUser();
              Navigator.pushNamed(context, Routes.homepage);
            },
            child: Row(
              children: [
                Container(
                    width: 20,
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete_outline)),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      'Delete Account',
                      softWrap: true,
                    )),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
