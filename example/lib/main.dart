import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Countdown',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: CircularCountdown(
          size: Size(
            300,
            300,
          ),
          countdownTotal: 10,
          countdownRemaining: 4,
          countdownTotalColor: Colors.white.withOpacity(0.5),
          countdownRemainingColor: Colors.red,
          strokeWidth: 50,
          gapFactor: 10,
        ),
      ),
    );
  }
}
