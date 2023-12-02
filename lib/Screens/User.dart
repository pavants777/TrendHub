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
          Navigator.pushReplacementNamed(context, Routes.home,
              arguments: [userEmail]);
        } else {
          Navigator.pushReplacementNamed(context, Routes.logIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCheckWidget(),
    );
  }
}

class AuthCheckWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
