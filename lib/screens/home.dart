import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screens/feedback.dart';
import 'package:quiz/screens/survey.dart';
import 'package:quiz/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final String userName =
      FirebaseAuth.instance.currentUser?.displayName ?? "Guest ";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () =>
                  Provider.of<AuthServiceProvider>(context).signOut(),
              child: const Icon(Icons.logout),
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.person))
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Hello,",
                        style: GoogleFonts.pacifico(
                          textStyle: text(30, FontWeight.w500, Colors.black),
                        ),
                        children: [
                          TextSpan(
                              text: userName,
                              style: GoogleFonts.pacifico(
                                  textStyle:
                                      text(30, FontWeight.w600, Colors.red)))
                        ]),
                  ),
                  Text(
                    "choose your destiny",
                    style: GoogleFonts.lato(
                        textStyle: text(15, FontWeight.normal, Colors.black)),
                  ),
                  const SizedBox(height: 25),
                  const kard(
                    txt: "Survey",
                    kolor: blueGradient,
                    destination: Survey(),
                  ),
                  const SizedBox(height: 50),
                  const kard(
                    txt: "Quiz",
                    kolor: orangeGradient,
                    destination: Survey(),
                  ),
                  const SizedBox(height: 50),
                  const kard(
                    txt: "Feedback",
                    kolor: purpleGradient,
                    destination: FeedbackScreen(),
                  ),
                ],
              ),
              Positioned(
                top: 100,
                right: 25,
                child: Image.asset(
                  "assets/icons/survey.png",
                  height: 100,
                  width: 100,
                ),
              ),
              Positioned(
                top: 300,
                right: 25,
                child: Image.asset(
                  "assets/icons/quiz.png",
                  height: 100,
                  width: 100,
                ),
              ),
              Positioned(
                top: 500,
                right: 25,
                child: Image.asset(
                  "assets/icons/feedback.png",
                  height: 100,
                  width: 100,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class kard extends StatelessWidget {
  final List<Color> kolor;
  final String txt;
  final Widget destination;
  const kard({
    Key? key,
    required this.txt,
    required this.kolor,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            gradient: LinearGradient(colors: kolor)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination,
              ),
            );
          },
          splashColor: Theme.of(context).splashColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 20),
            child: Text(
              txt,
              style: GoogleFonts.lato(
                  textStyle: text(20, FontWeight.w400, Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
