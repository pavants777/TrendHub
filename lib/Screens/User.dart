import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';

class UserCheck extends StatefulWidget {
  @override
  State<UserCheck> createState() => _UserState();
}

class _UserState extends State<UserCheck> {
  bool _initialized = false;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!_initialized) {
        _initialized = true;
        if (user != null) {
          bool isEmailVerified =
              FirebaseAuth.instance.currentUser!.emailVerified;
          if (!isEmailVerified) {
            Navigator.pushReplacementNamed(context, Routes.emailVerification);
          } else {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        } else {
          Navigator.pushReplacementNamed(context, Routes.logIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
