import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/fetch.dart';
import '../services/store.dart';
import 'feedbacc_question_editor.dart';

class Admeme_Feedbacc extends StatelessWidget {
  const Admeme_Feedbacc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Fetch().feedbackQuestions(),
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
                          .delFeedbaccQuestion(timestamp: que[index]["tme"]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        enableFeedback: true,
                        tileColor: Color.fromARGB(255, 243, 234, 234),
                        title: Text(
                          que[index]["question"],
                          style: TextStyle(fontSize: 17),
                        ),
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
          CupertinoPageRoute(builder: (context) => const EditorPage2()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
