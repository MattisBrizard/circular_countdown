import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';

class StaticCountdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Static CircularCountdown'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularCountdown(
              diameter: 250,
              countdownTotal: 10,
              countdownRemaining: 7,
            ),
          ],
        ),
      ),
    );
  }
}
