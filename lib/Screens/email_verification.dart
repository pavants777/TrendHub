import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/utils/alert.dart';

class EmailVerification extends StatefulWidget {
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //check is user is verified is email or not
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
    }

    timer = Timer.periodic(Duration(seconds: 3), (_) {
      checkEmailVerified();
    });
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
      Navigator.pushNamed(context, Routes.home);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
      alert(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verify Your Email',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Email Verification Is Sent To Your Email',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Check Your InBox',
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                sendVerificationEmail();
              },
              child: Text(
                'Resend It',
                style: TextStyle(color: Colors.blue),
              )),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser!.delete();
                Navigator.pushNamed(context, Routes.logIn);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              )),
        ],
      )),
    );
  }
}
