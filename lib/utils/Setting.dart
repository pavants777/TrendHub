import 'package:flutter/material.dart';

Widget SettingsScreen(BuildContext context) {
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
            onPressed: () {},
            child: Row(
              children: [
                Container(
                    width: 30,
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.settings)),
                Container(
                    width: 70,
                    alignment: Alignment.center,
                    child: Text(
                      'Settings',
                      softWrap: false,
                    )),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
