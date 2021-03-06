import 'package:flutter/material.dart';

import 'package:quiz/pages/landing_page.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ScorePage({this.score, this.totalQuestions});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Your Score: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            score.toString() + '/' + totalQuestions.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_right,
            ),
            // onPressed: () => print('Pressed icon button'),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LandingPage()), (Route route) => route == null),
            color: Colors.white,
            iconSize: 50.0,
          ),
        ],
      ),
    );
  }
}
