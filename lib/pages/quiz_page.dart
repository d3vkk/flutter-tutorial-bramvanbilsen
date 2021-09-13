/* ===============================
   QUIZ PAGE STATEFUL WIDGET
   =============================== */

import 'package:flutter/material.dart';

import 'package:quiz/utils/quiz.dart';
import 'package:quiz/utils/question.dart';

import 'package:quiz/UI/answer_button.dart';
import 'package:quiz/UI/question_text.dart';
import 'package:quiz/UI/answer_overlay.dart';

import 'package:quiz/pages/score_page.dart';

class QuizPage extends StatefulWidget {
  // this class is not actually mutable but creates
  // a mutable state class
  @override
  _QuizPageState createState() => _QuizPageState();

}

class _QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool showOverlay = false;

  Quiz quiz = new Quiz([
    Question(question: "A crocodile doesn't have a tongue", trueorfalse: true),
    Question(question: "Camels have three eyelashes", trueorfalse: true),
    Question(question: "Male lions hunt more than female lions", trueorfalse: false),
    Question(question: "Hummingbirds can fly backwards", trueorfalse: true),
    Question(question: "Man came from the chimpanzee", trueorfalse: false),
    Question(question: "An octopus has bones", trueorfalse: false),
    Question(question: "Geckos have eyelids", trueorfalse: false),
    Question(question: "Owls can turn their head 360 degrees", trueorfalse: false),
    Question(question: "Rabbits are born blind", trueorfalse: true),
    Question(question: "Camels strore water in their humps", trueorfalse: false),
    Question(question: "Ostriches can fly", trueorfalse: false),
  ]);

  // Triggered when the page loads
  @override
  void initState() {
    super.initState();
    /*
      Note that nextQuestion inherits the
      variables or properties of the class Question

      So quiz.nextQuestion.question and
      quiz.nextQuestion.trueorfalse
      are now its properties
    */
    currentQuestion = quiz.nextQuestion;
    print(currentQuestion.toString());

    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void checkAnswer(bool answer) {
    /*
      if the statement, currentQuestion.trueorfalse == answer
      is true, then isCorrect will be equal to true,
      if it is false, then isCorrect will be equal to false
    */
    isCorrect = (currentQuestion.trueorfalse == answer);
    quiz.calcScore(isCorrect);

    setState(() {
      showOverlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // will ensure the children take as much space as possible
      // in this case, for the answer overlay to do so
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          // Main Page is a column
          children: <Widget>[
            // True button
            AnswerButton(
              button: true,
              // whentapped: () => print('You answered true'),
              whentapped: () => checkAnswer(true),
            ),
            // Question
            QuestionText(
                questionText: questionText, questionNumber: questionNumber),
            // False button
            AnswerButton(
              button: false,
              // whentapped: () => print('You answered false'),
              whentapped: () => checkAnswer(false),
            ),
          ],
        ),
        showOverlay
            ? AnswerOverlay(
                isCorrect: isCorrect,
                whentapped: () {
                  // check if last question has been reached
                  // if so, redirect the page
                  if (quiz.length == questionNumber) {
                    /*
                      Redirects page and removes the all the previous pages
                      until the route is zero
                      so that the user can't navigate back
                    */
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (BuildContext context) => ScorePage(score: quiz.score, totalQuestions: quiz.length,)), (Route route) => route == null);
                  }
                  // Else, Go to next question
                  currentQuestion = quiz.nextQuestion;
                  setState(() {
                    // hide overlay
                    showOverlay = false;
                    // change question
                    questionText = currentQuestion.question;
                    questionNumber = quiz.questionNumber;
                  });
                },
              )
            : Container(), //empty Container
      ],
    );
  }
}
