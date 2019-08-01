import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:circular_countdown/src/circular_countdown_painter.dart';

void main() {
  test('CircularCountdownPainter currentPaint should be null', () {
    CircularCountdownPainter painter = CircularCountdownPainter(
      countdownTotal: 10,
      countdownRemaining: 6,
      countdownTotalColor: Color(0X4DFFFFFF),
      countdownRemainingColor: Color(0XFFFFFFFF),
      strokeWidth: 40,
      gapFactor: 2,
    );

    expect(painter.currentPaint, null);
  });
  test('CircularCountdownPainter currentPaint should be correct', () {
    CircularCountdownPainter painter = CircularCountdownPainter(
      countdownTotal: 10,
      countdownRemaining: 6,
      countdownTotalColor: Color(0X4DFFFFFF),
      countdownRemainingColor: Color(0XFFFFFFFF),
      countdownCurrentColor: Color(0XFFF4CAF5),
      strokeWidth: 40,
      gapFactor: 2,
    );

    expect(painter.currentPaint.color, Color(0XFFF4CAF5));
    expect(painter.currentPaint.strokeWidth, 40);
    expect(painter.currentPaint.style, PaintingStyle.stroke);
  });
}
