import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:gap/gap.dart';

class StaticCountdownPage extends StatelessWidget {
  const StaticCountdownPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static CircularCountdown'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: const <Widget>[
          Gap(50),
          CircularCountdown(
            diameter: 200,
            gapFactor: 2,
            strokeWidth: 100,
            countdownTotal: 10,
            countdownRemaining: 7,
          ),
          Gap(50),
          CircularCountdown(
            diameter: 250,
            countdownTotal: 10,
            countdownRemaining: 2,
            strokeWidth: 5,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 90,
            ),
          ),
          Gap(50),
          CircularCountdown(
            diameter: 250,
            countdownTotal: 10,
            countdownRemaining: 7,
            countdownCurrentColor: Color(0xFFFE5F55),
            countdownRemainingColor: Color(0xFF4F6367),
            countdownTotalColor: Colors.transparent,
            textStyle: TextStyle(
              color: Color(0xFFFE5F55),
              fontSize: 90,
            ),
          ),
          Gap(50),
          CircularCountdown(
            diameter: 250,
            countdownTotal: 10,
          ),
          Gap(50),
        ],
      ),
    );
  }
}
