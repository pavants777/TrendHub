import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/constant/constant.dart';
import 'package:trendhub/functions/databasecollection.dart';
import 'package:trendhub/utils/alert.dart';
import 'package:trendhub/utils/companyName.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _userName = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _email.clear();
    _password.clear();
    _userName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CompanyName(
            logofontSize: 25,
            textfontSize: 15,
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
              width: 300,
              child: TextField(
                controller: _userName,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'UserName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
              width: 300,
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
              width: 300,
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key),
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              )),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _email.text, password: _password.text)
                  .then((value) {
                createUser(_email.text, _userName.text, Constant.imageUrl,
                    Constant.backgroundimageurl);
                Navigator.pushNamed(context, Routes.emailVerification);
                _email.clear();
                _password.clear();
              }).onError((error, stackTrace) {
                String errormessage = error.toString();
                alert(context, errormessage);
                _email.clear();
                _password.clear();
              });
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: 100,
              child: Text(
                'SignUp',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Already have an Account ?"),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.logIn);
                },
                child: const Text(
                  ' Log In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 100,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              SizedBox(width: 10),
              Text(
                'OR',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 10),
              Container(
                height: 1,
                width: 100,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/01.webp',
                width: 40,
                height: 40,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
