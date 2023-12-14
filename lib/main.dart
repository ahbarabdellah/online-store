import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetuto/Pages/main_page.dart';
import 'package:firebasetuto/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterTutoApp());
}

class FlutterTutoApp extends StatelessWidget {
  const FlutterTutoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
