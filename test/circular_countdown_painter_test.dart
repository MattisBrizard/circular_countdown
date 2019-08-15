import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:circular_countdown/src/circular_countdown_painter.dart';

void main() {
  test('CircularCountdownPainter currentPaint should be null', () {
    final CircularCountdownPainter painter = CircularCountdownPainter(
      countdownTotal: 10,
      countdownRemaining: 6,
      countdownTotalColor: const Color(0X4DFFFFFF),
      countdownRemainingColor: const Color(0XFFFFFFFF),
      strokeWidth: 40,
      gapFactor: 2,
    );

    expect(painter.currentPaint, null);
  });
  test('CircularCountdownPainter currentPaint should be correct', () {
    final CircularCountdownPainter painter = CircularCountdownPainter(
      countdownTotal: 10,
      countdownRemaining: 6,
      countdownTotalColor: const Color(0X4DFFFFFF),
      countdownRemainingColor: const Color(0XFFFFFFFF),
      countdownCurrentColor: const Color(0XFFF4CAF5),
      strokeWidth: 40,
      gapFactor: 2,
    );

    expect(painter.currentPaint.color, const Color(0XFFF4CAF5));
    expect(painter.currentPaint.strokeWidth, 40);
    expect(painter.currentPaint.style, PaintingStyle.stroke);
  });
}
