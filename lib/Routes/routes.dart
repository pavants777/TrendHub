import 'package:flutter/material.dart';
import 'package:trendhub/Screens/User.dart';
import 'package:trendhub/Screens/home.dart';
import 'package:trendhub/Screens/homepage.dart';
import 'package:trendhub/Screens/login.dart';
import 'package:trendhub/Screens/signin.dart';

class Routes {
  static const String homepage = '/';
  static const String signIn = '/signin';
  static const String logIn = '/login';
  static const String home = '/home';
  static const String userCheck = '/user';

  static Map<String, WidgetBuilder> routes = {
    homepage: (context) => HomePage(),
    signIn: (context) => SignIn(),
    logIn: (context) => LogIn(),
    home: (context) => Home(),
    userCheck: (context) => UserCheck(),
  };
}
