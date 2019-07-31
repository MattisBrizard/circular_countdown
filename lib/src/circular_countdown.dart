import 'package:flutter/material.dart';

import 'circular_countdown_painter.dart';

class CircularCountdown extends StatelessWidget {
  const CircularCountdown({
    Key key,
    @required this.size,
    @required this.countdownTotal,
    @required this.countdownRemaining,
    this.countdownTotalColor = Colors.white60,
    this.countdownRemainingColor = Colors.white,
    this.countdownCurrentColor = Colors.white,
    this.gapFactor = 5,
    this.strokeWidth,
  })  : assert(countdownTotal != null),
        assert(countdownRemaining != null),
        super(key: key);

  final Size size;
  final int countdownTotal;
  final int countdownRemaining;
  final Color countdownTotalColor;
  final Color countdownRemainingColor;
  final Color countdownCurrentColor;
  final double gapFactor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularCountdownPainter(
        countdownTotal: countdownTotal,
        countdownRemaining: countdownRemaining,
        countdownTotalColor: countdownTotalColor,
        countdownRemainingColor: countdownRemainingColor,
        countdownCurrentColor: countdownCurrentColor,
        gapFactor: gapFactor,
        strokeWidth: strokeWidth,
      ),
      size: size,
    );
  }
}
