import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/input.dart';
import 'package:quiz/screens/home.dart';
import 'package:quiz/screens/login.dart';
import 'package:quiz/services/auth.dart';

import '../components/button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController otp = TextEditingController();
  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 140,
          ),
          InputSection(
            controller: name,
            descriptor: "Name",
          ),
          InputSection(
            controller: email,
            descriptor: "Email ID",
          ),
          InputSection(
            controller: password,
            descriptor: "Password",
            isPasword: true,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: otp,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                label: Text("OTP"),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          BigButton(
              onPressed: () {
                Provider.of<AuthServiceProvider>(context, listen: false)
                    .sendOtp(email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("OTP SENT"),
                  ),
                );
              },
              buttonChild: const Text("Send OTP")),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool status =
              await Provider.of<AuthServiceProvider>(context, listen: false)
                  .verify(inputOTP: otp.text);
          setState(() {
            isVerified = status;
          });
          if (!isVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("OTP VERIFICATION UNSUCCESSFUl"),
              ),
            );
            return;
          }
          try {
            UserCredential userCreds =
                await Provider.of<AuthServiceProvider>(context, listen: false)
                    .addUser(email.text, password.text);
            userCreds.user!.updateDisplayName(name.text);

            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => const LoginScreen()));
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  e.code.toString().split("-").join(" ").toUpperCase(),
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.navigate_next),
        elevation: 20,
        disabledElevation: 2,
      ),
    );
  }
}
