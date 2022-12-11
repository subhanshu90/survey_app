import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/screens/admeme_feedbacc.dart';
import 'package:quiz/screens/admeme_survey.dart';
import 'package:quiz/services/store.dart';
import '../services/fetch.dart';
import 'login.dart';
import 'question_editor.dart';

class Admeme extends StatelessWidget {
  const Admeme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: [
          GridTile(
            footer: Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  "Quiz Questions",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            ),
            child: InkWell(
              child: Image.asset("assets/icons/quiz.png"),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const QuizQuestionEditor())),
            ),
          ),
          GridTile(
            footer: Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  "Feedback Questions",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            ),
            child: InkWell(
              child: Image.asset("assets/icons/feedback.png"),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const Admeme_Feedbacc())),
            ),
          ),
          GridTile(
            footer: Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  "Survey Questions",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            ),
            child: InkWell(
              child: Image.asset("assets/icons/survey.png"),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const Admeme_Survey())),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizQuestionEditor extends StatelessWidget {
  const QuizQuestionEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Fetch().fetchQuizQuestons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset("assets/icons/1.png"),
            );
          }
          Map<String, dynamic> jsonQuestions =
              snapshot.data!.data() as Map<String, dynamic>;

          List que = jsonQuestions.entries
              .map((e) => {'tme': e.key, 'question': e.value['question']})
              .toList();
          if (que.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "no question found",
                    style: GoogleFonts.lato(fontSize: 30),
                  ),
                  Text(
                    "please add some using the add button",
                    style: GoogleFonts.lato(fontSize: 20),
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: que.length,
                itemBuilder: ((context, index) {
                  return Dismissible(
                    key: ValueKey<String>(que[index]["tme"]),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (DismissDirection direction) {
                      Provider.of<DataBaseProvider>(context, listen: false)
                          .delQuizQuestion(timestamp: que[index]["tme"]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        enableFeedback: true,
                        tileColor: Color.fromARGB(255, 243, 234, 234),
                        title: Text(que[index]["question"]),
                      ),
                    ),
                  );
                })),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const EditorPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
