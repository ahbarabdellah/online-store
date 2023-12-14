import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuto/Pages/home_page.dart';
import 'package:firebasetuto/Pages/login_page.dart';
import 'package:firebasetuto/Pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isSignIn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return isSignIn
                ? LoginPage(showRegisterPage: showRegisterPage)
                : SignUpPage(showRegisterPage: showRegisterPage);
          }
        },
      ),
    );
  }

  void showRegisterPage() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }
}
