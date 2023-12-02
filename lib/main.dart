import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrendHub',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
