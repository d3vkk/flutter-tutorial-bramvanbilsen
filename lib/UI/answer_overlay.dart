/* ========================================================
   ANSWER OVERLAY STATEFUL WIDGET: ANIMATION that tells
   the user if their answer is right or wrong
   in QUIZ PAGE
   ======================================================== */

import 'dart:math';

import 'package:flutter/material.dart';

class AnswerOverlay extends StatefulWidget {
  final bool isCorrect;
  final VoidCallback whentapped;
  AnswerOverlay({this.isCorrect, this.whentapped});

  @override
  _AnswerOverlayState createState() => _AnswerOverlayState();
}

class _AnswerOverlayState extends State<AnswerOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _iconAnimation =
        CurvedAnimation(parent: _iconController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _iconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: InkWell(
        // onTap: () => print('You tapped the overlay'),
        onTap: () => widget.whentapped(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              // Equivalent of CSS rotate property
              child: Transform.rotate(
                // Icon will rotate 360 degrees
                angle: _iconAnimation.value * pi * 2,
                child: Icon(
                  widget.isCorrect ? Icons.done : Icons.clear,
                  size: _iconAnimation.value * 80.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Text(
              widget.isCorrect ? "Correct!" : "Wrong!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
