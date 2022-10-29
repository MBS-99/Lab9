import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ourlab/screens/logIn.dart';
import 'package:ourlab/screens/signUp.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MaterialApp(
    home: MyApp(),
  ));
//...
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LogIn();
  }
}
