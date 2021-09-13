/* ============================================
   QUIZ CLASS: main functions for the app
   in QUIZ PAGE
   ============================================ */

import 'package:quiz/utils/question.dart';

class Quiz {
  // _questions inherits the variables of the class Question
  List<Question> _questions;
  /*
    _questionIndex is subtracted by one so that
    when fetching the first question from the list,
    it is incremented (see nextQuestion below)
    and it starts from 0
  */
  int _questionIndex = -1;
  int _score = 0;

  //Alternative way of writing constructor
  Quiz(this._questions) {
    //will randomize the questions
    _questions.shuffle();
  }

  //computed properties/getters
  List<Question> get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _questionIndex + 1;
  int get score => _score;
  // nextQuestion inherits the variables of the class Question
  Question get nextQuestion {
    _questionIndex++;
    //checks if all the questions are done
    // if not, sends the next question
    return _questionIndex >= length ? null : _questions[_questionIndex];
  }

  void calcScore(bool isCorrect) {
    //Note: how to shorten an if statement
    if (isCorrect) _score++;
  }
}
