import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:adv_basics/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  final List<String> selectedAnswer = [];
  //var activeScreen = 'start-screen';

  // below method not required if we use identifier solution
  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswers: selectedAnswer,
          onRestart: onRestart,
        );
      });
    }
  }

  void onRestart() {
    setState(() {
      selectedAnswer.clear();
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
      //activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    //final screenWidget = activeScreen == 'start-screen'
    //    ? StartScreen(switchScreen)
    //    : const QuestionsScreen();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 136, 97, 205),
                Color.fromARGB(255, 83, 30, 174),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
          //child: screenWidget
        ),
      ),
    );
  }
}
