import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/services/store.dart';

class EditorPage2 extends StatefulWidget {
  const EditorPage2({
    super.key,
  });

  @override
  State<EditorPage2> createState() => _EditorPage2State();
}

class _EditorPage2State extends State<EditorPage2> {
  final TextEditingController _quescontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Questions"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: TextField(
                controller: _quescontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("questions")),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          Provider.of<DataBaseProvider>(context, listen: false)
              .setFeedbackQuestion(question: _quescontroller.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
