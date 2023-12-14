// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? showRegisterPage;

  const SignUpPage({super.key, required this.showRegisterPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailControler = TextEditingController();
  final _passwordControler = TextEditingController();
  final _confpasswordControler = TextEditingController();
  final _userNameControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.face,
                    size: 100,
                    color: Colors.deepPurple,
                  ),
                  const Text(
                    "Hello There !",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "register Now and Start Learning :)",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _userNameControler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "UserName",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailControler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordControler,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _confpasswordControler,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: singUp,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a member ? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addinfos(String username) async {
    print('😑 adding user ');
    await FirebaseFirestore.instance.collection("collectionPath").add({
      "user": username,
    });
  }

  void singUp() async {
    if (_passwordControler.text.isNotEmpty &&
        _confpasswordControler.text.isNotEmpty &&
        _emailControler.text.isNotEmpty) {
      if (_passwordControler.text == _confpasswordControler.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailControler.text, password: _passwordControler.text);

          addinfos(_userNameControler.text.trim());
        } on FirebaseAuthException catch (e) {
          String errorMsg = "";

          if (e.code == "email-already-in-use") {
            errorMsg = 'email already in use !';
          } else if (e.code == "invalid-email") {
            errorMsg = 'invalid email !';
          } else if (e.code == "operation-not-allowed") {
            errorMsg = "operation not allowed";
          } else if (e.code == "weak-password") {
            errorMsg = "weak password";
          }

          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'ERORR : $errorMsg',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'ERORR : Password Does Not mutch!',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'ERORR : Enter your credentials',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }
}
