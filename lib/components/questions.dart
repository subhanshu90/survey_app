import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/button.dart';
import 'package:quiz/constants/constants.dart';
import 'package:quiz/services/points.dart';
import 'package:quiz/services/store.dart';
import 'mcqs.dart';

class Questions extends StatefulWidget {
  final MCQ qn;

  final PageController controller;
  const Questions({
    super.key,
    required this.qn,
    required this.controller,
  });

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int selectedIndex = -1;

  void setSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    widget.qn.question,
                    style: GoogleFonts.mukta(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.qn.options.length,
                  itemBuilder: (BuildContext context, int index) => Kard2(
                    txt: widget.qn.options.elementAt(index),
                    kolor: purpleGradient,
                    index: index,
                    selectedIndex: selectedIndex,
                    setSelected: setSelected,
                  ),
                ),
              ],
            ),
          ),
          BigButtonWithIcon(
            onPressed: () {
              if (selectedIndex < 0) return;
              bool status = widget.qn.validate(selectedIndex);
              if (status) {
                Provider.of<PointsCountProvider>(context, listen: false)
                    .nailedit();
              } else {
                Provider.of<PointsCountProvider>(context, listen: false)
                    .wronged();
              }

              widget.controller.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            buttonIcon: const Icon(Icons.navigate_next),
            buttonLable: const Text("Validate"),
          ),
          const SizedBox(
            height: 10,
          ),
          BigButtonWithIcon(
            onPressed: () {
              Provider.of<PointsCountProvider>(context, listen: false).jumped();
              widget.controller.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
            buttonIcon: const Icon(Icons.navigate_next),
            buttonLable: const Text("Skip"),
          )
        ],
      ),
    );
  }
}

class Questions2 extends StatefulWidget {
  final MCQ2 qn;

  final PageController controller;
  const Questions2({
    super.key,
    required this.qn,
    required this.controller,
  });

  @override
  State<Questions2> createState() => _Questions2State();
}

class _Questions2State extends State<Questions2> {
  int selectedIndex = -1;

  void setSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final TextEditingController _surveyans = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    widget.qn.question,
                    style: GoogleFonts.mukta(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 39,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 6,
                    textInputAction: TextInputAction.done,
                    controller: _surveyans,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 239, 226, 226),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ],
            ),
          ),
          BigButtonWithIcon(
            onPressed: () {
              Provider.of<DataBaseProvider>(context, listen: false)
                  .addAns(_surveyans.text, widget.qn.question);

              widget.controller.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
            buttonIcon: const Icon(Icons.navigate_next),
            buttonLable: const Text("Next"),
          )
        ],
      ),
    );
  }
}

class Kard2 extends StatelessWidget {
  final List<Color> kolor;
  final String txt;
  final int index;
  final int selectedIndex;
  final Function setSelected;
  const Kard2({
    Key? key,
    required this.txt,
    required this.kolor,
    required this.index,
    required this.selectedIndex,
    required this.setSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            gradient: LinearGradient(
              colors:
                  selectedIndex != index ? [Colors.white, Colors.white] : kolor,
            )),
        child: InkWell(
          onTap: () => setSelected(index),
          splashColor: Theme.of(context).splashColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: Text(
                String.fromCharCode(index + 65),
                style: GoogleFonts.lato(
                  textStyle: text(
                    20,
                    FontWeight.w400,
                    selectedIndex != index ? Colors.black : Colors.white,
                  ),
                ),
              ),
              title: Text(
                txt,
                style: GoogleFonts.lato(
                    textStyle: text(
                  20,
                  FontWeight.w400,
                  selectedIndex != index ? Colors.black : Colors.white,
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
