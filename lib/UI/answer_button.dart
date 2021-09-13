/* ========================================================
   ANSWER BUTTON STATELESS WIDGET: element
   in QUIZ PAGE
   ======================================================== */

import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  // Stateless Widgets' variables must all have 'final' keyword

  // This bool is used to determine how to render the button
  final bool button;

  /*
    'VoidCallback' is a function that can only
    has a body with no parameters and return values

    It is declared as a variable in a class but instead of
    taking in a value, it takes in a body
  */
  final VoidCallback whentapped; // Equivalent of void whentapped(){}

  AnswerButton({this.button, this.whentapped});

  @override
  Widget build(BuildContext context) {
    /*
      Children of Column widgets take as little space as possible
      Hence the need for expanded widget which will take as much space as possible
    */
    return Expanded(
      child: Material(
        color: button ? Colors.greenAccent : Colors.redAccent,
        child: InkWell(
          // similar to ES6 Javascript arrow functions
          onTap: () => whentapped(),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(
                button ? 'True' : 'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
