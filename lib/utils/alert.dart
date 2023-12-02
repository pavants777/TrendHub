import 'package:flutter/material.dart';

Future<dynamic> alert(BuildContext context, String error) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Invalid Details'),
        content: Text('$error'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
