// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;
  const ForgotPasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    var emailControler = TextEditingController();

    @override
    void dispose() {
      emailControler.dispose();
      super.dispose();
    }

    Future passwordReset() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailControler.text.trim());

        const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'Done Seccusfuly ! check your email.',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        String errorMsg = "Sorry :(";
        switch (e.code) {
          case "auth/invalid-email":
            errorMsg = "invalid email";
            break;
          case "auth/user-not-found":
            errorMsg = "user not found";
            break;
          default:
            errorMsg = "Sorry :( ; Something went wrong !";
            break;
        }
        if (emailControler.text.trim().isEmpty) {
          errorMsg = " Enter your email";
        }
        var snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
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

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 212, 187, 255),
          title: const Text("Reset your password")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your Email and we will send you a password reset link.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailControler,
                decoration: const InputDecoration(
                    hintText: "Enter your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: passwordReset,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple),
                  child: const Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
