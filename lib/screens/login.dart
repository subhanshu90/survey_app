import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/button.dart';
import 'package:quiz/screens/admeme.dart';
import 'package:quiz/screens/home.dart';
import 'package:quiz/screens/signup.dart';
import 'package:quiz/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isHidden=true;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Column(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    validator: validateEmail,
                    controller: email,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    validator: validatePassword,
                    controller: password,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    obscureText: _isHidden,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.lock),
                      suffix: Inkwell(onTap: _togglePasswordView,
                        child: Icon(_isHidden
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BigButton(
                  onPressed: () async {
                    try {
                      if (_key.currentState!.validate()) {
                        if (email.text.trim() == "admin@app.com") {
                          if (password.text.trim() != "strongpass@123") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: const Text("wrong password")),
                            );
                            return;
                          }
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (builder) => const Admeme()),
                              (Route<dynamic> route) => false);
                          return;
                        }
                        final AuthServiceProvider provider =
                            Provider.of<AuthServiceProvider>(context,
                                listen: false);
                        await provider.signInWithPassword(
                            email.text.trim(), password.text.trim());
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(builder: (builder) => Home()),
                            (Route<dynamic> route) => false);
                      }
                    } on FirebaseAuthException catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            error.code
                                .toString()
                                .split("-")
                                .join(' ')
                                .toUpperCase(),
                          ),
                        ),
                      );
                    }
                  },
                  buttonChild: const Text("Login"),
                ),
                BigButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    buttonChild: const Text("Sign Up")),
              ])),
        ),
      ),
    );
  }
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Email address is required";
  }
  String pattern = r'\w+@\w+.\w+';
  RegExp regEx = RegExp(pattern);
  if (!regEx.hasMatch(email)) {
    return "Invalid Email Address";
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Password is required";
  }
  if (password.length < 8) {
    return "Must longer than 8 characters";
  }

  return null;
}
