import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Painter that draws the circular countdown.
///
/// Will repaint only if his parameters has changed.
class CircularCountdownPainter extends CustomPainter {
  CircularCountdownPainter({
    @required this.countdownTotal,
    @required this.countdownRemaining,
    this.countdownTotalColor,
    this.countdownRemainingColor,
    this.countdownCurrentColor,
    this.strokeWidth,
    this.gapFactor,
  });
  final int countdownTotal;
  final int countdownRemaining;
  final Color countdownTotalColor;
  final Color countdownRemainingColor;
  final Color countdownCurrentColor;
  final double gapFactor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint remainingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = countdownRemainingColor;

    final Paint totalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = countdownTotalColor;

    Paint currentPaint;
    if (countdownCurrentColor != null) {
      currentPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = countdownCurrentColor;
    }

    final double emptyArcSize = 2 * math.pi / (gapFactor * countdownTotal);
    final double fullArcSize = 2 * math.pi / countdownTotal - emptyArcSize;

    ui.Paint paint;
    for (int unit = 0; unit < countdownTotal; unit++) {
      if (currentPaint != null) {
        if (countdownTotal - unit < countdownRemaining) {
          paint = remainingPaint;
        } else if (countdownTotal - unit == countdownRemaining) {
          paint = currentPaint;
        } else {
          paint = totalPaint;
        }
      } else {
        if (countdownTotal - unit <= countdownRemaining) {
          paint = remainingPaint;
        } else {
          paint = totalPaint;
        }
      }

      final double startAngle =
          -math.pi / 2 + unit * (emptyArcSize + fullArcSize) + emptyArcSize / 2;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: (size.width / 2),
        ),
        startAngle,
        fullArcSize,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularCountdownPainter oldDelegate) {
    return (countdownTotal != oldDelegate.countdownTotal ||
        countdownRemaining != oldDelegate.countdownRemaining ||
        countdownTotalColor != oldDelegate.countdownTotalColor ||
        countdownRemainingColor != oldDelegate.countdownRemainingColor ||
        countdownCurrentColor != oldDelegate.countdownCurrentColor ||
        gapFactor != oldDelegate.gapFactor ||
        strokeWidth != oldDelegate.strokeWidth);
  }
}
