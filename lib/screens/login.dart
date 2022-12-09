import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/button.dart';
import 'package:quiz/screens/home.dart';
import 'package:quiz/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: Center(
              child: BigButtonWithIcon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CircularProgressIndicator()));
                  Provider.of<AuthServiceProvider>(context).signInWithGoogle();
                },
                buttonIcon: const Icon(Icons.person_add_alt_1_rounded),
                buttonLable: const Text("Login With Google"),
              ),
            ),
          );
        });
  }
}
