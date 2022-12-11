import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/services/store.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({
    super.key,
  });

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  int corr = 1;
  final TextEditingController _quescontroller = TextEditingController();

  final TextEditingController _opt1controller = TextEditingController();

  final TextEditingController _opt2controller = TextEditingController();

  final TextEditingController _opt3controller = TextEditingController();

  final TextEditingController _opt4controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> cunt = [
      _opt1controller,
      _opt2controller,
      _opt3controller,
      _opt4controller,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Questions"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _quescontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Question"),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                enableFeedback: true,
                title: TextField(
                  controller: cunt[index - 1],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Options"),
                ),
                leading: Text("${index}"),
                trailing: ElevatedButton(
                  child: corr == index
                      ? const Icon(Icons.check)
                      : const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      corr = index;
                    });
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          List<String> options = [];
          for (int i = 0; i < cunt.length; i++) {
            var element = cunt[i];
            if (element.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("option ${i + 1} is empty")));
              return;
            }
            options.add(element.text);
          }
          Provider.of<DataBaseProvider>(context, listen: false).setQuizQuestion(
              question: _quescontroller.text,
              options: options,
              correct: corr - 1);
          Navigator.pop(context);
        },
      ),
    );
  }
}
