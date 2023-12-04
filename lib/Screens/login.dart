import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/utils/alert.dart';
import 'package:trendhub/utils/companyName.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

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
                controller: _email,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
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
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email.text,
                  password: _password.text,
                );
                Navigator.pushReplacementNamed(context, Routes.home);
                _email.clear();
                _password.clear();
              } catch (error) {
                String errorMessage = error.toString();
                print("Error during sign-in: $errorMessage");
                alert(context, errorMessage);
                _email.clear();
                _password.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: 100,
              child: Text(
                'LogIn',
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
              Text("Don't hava account ?"),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.signIn);
                },
                child: const Text(
                  ' Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 100,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              const SizedBox(width: 10),
              const Text(
                'OR',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 10),
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
              GestureDetector(
                onTap: () {
                  // _siginWithGoogle(context);
                },
                child: Image.asset(
                  'assets/01.webp',
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

// _siginWithGoogle(BuildContext context) async {
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//       clientId:
//           '314632280367-gnl40a34iu6t4k9e21b5alq74qq0vllt.apps.googleusercontent.com');

//   try {
//     final GoogleSignInAccount? googleSignInAccount =
//         await _googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushNamed(context, Routes.home);
//     }
//   } catch (e) {
//     print("some Error Occured $e");
//   }

// }
