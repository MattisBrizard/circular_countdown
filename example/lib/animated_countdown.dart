import 'dart:async';

import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';

class AnimatedCountdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated CircularCountdown'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _AnimatedCountdown(strokeWidth: 125),
            _AnimatedCountdown(strokeWidth: 40),
          ],
        ),
      ),
    );
  }
}

class _AnimatedCountdown extends StatefulWidget {
  const _AnimatedCountdown({Key key, this.strokeWidth}) : super(key: key);
  final double strokeWidth;

  @override
  _AnimatedCountdownState createState() => _AnimatedCountdownState();
}

class _AnimatedCountdownState extends State<_AnimatedCountdown> {
  final totalSeconds = 30;
  int seconds;
  Timer timer;

  @override
  void initState() {
    seconds = totalSeconds;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (--seconds == 0) {
        timer.cancel();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularCountdown(
      diameter: 250,
      countdownTotal: totalSeconds,
      countdownRemaining: seconds,
      countdownCurrentColor: Colors.orange,
      gapFactor: 4,
      strokeWidth: widget.strokeWidth,
    );
  }
}
