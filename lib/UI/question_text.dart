/* =============================================
   QUESTION TEXT STATEFUL WIDGET: element
   in QUIZ PAGE
   ============================================= */

import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String questionText;
  final int questionNumber;

  QuestionText({this.questionText, this.questionNumber});
  @override
  _QuestionTextState createState() => _QuestionTextState();
}

class _QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  // Animation is a double because it increments from 0 to 1
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeController;

  @override
  void initState() {
    super.initState();
    // Triggered when the page loads

    // vsync handles animations that go outside the screen boundary
    // it requires SingleTickerProviderStateMixin to do so
    _fontSizeController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    /*
      The curves chosen have to above the x-axis
      i.e. can't go below 0 or are positive
      since the fontSize has to be a positive number
    */
    _fontSizeAnimation =
        CurvedAnimation(parent: _fontSizeController, curve: Curves.bounceOut);
    /*
      This empty setState will listen for the fontSize changes
      With every change, it will rebuild the text
      according to that fontSize
    */
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    // When an Animation has finished rendering,
    // the Animation controller needs to be disposed
    // so that it can free the resources it was holding
    _fontSizeController.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Will perform the animation every time
    // the widget updates or changes in any way

    if (oldWidget.questionText != widget.questionText) {
      _fontSizeController.reset();
      _fontSizeController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text(
            "Statement " +
                // How you access a variable in a Stateful Widget,
                widget.questionNumber.toString() +
                ": " +
                widget.questionText,
            // fontSize will increment from 0 to 15
            style: TextStyle(fontSize: _fontSizeAnimation.value * 15),
          ),
        ),
      ),
    );
  }
}
