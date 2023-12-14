import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuto/Pages/forgot_pswrd_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailControler = TextEditingController();
  final _passwordControler = TextEditingController();
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
                    "Welcome Back !",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "you have been missed :)",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ForgotPasswordPage(
                            email: _emailControler.text.trim());
                      }));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot a password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: SingIn,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple),
                      child: const Center(
                        child: Text(
                          "Sign In",
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
                        "Not a member ? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          "Sign Up",
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

  // ignore: non_constant_identifier_names
  void SingIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailControler.text, password: _passwordControler.text);
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }
}
