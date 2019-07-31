import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Painter that draws the circular countdown
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
  double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (strokeWidth == null) {
      strokeWidth = size.width / 8;
    }

    final Paint remainingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = countdownRemainingColor;
    final Paint totalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = countdownTotalColor;

    final double emptyArcSize = 2 * math.pi / (gapFactor * countdownTotal);
    final double fullArcSize = 2 * math.pi / countdownTotal - emptyArcSize;

    ui.Paint paint;
    for (int unit = 0; unit < countdownTotal; unit++) {
      if (countdownTotal - unit < countdownRemaining) {
        paint = remainingPaint;
      } else {
        paint = totalPaint;
      }

      final double startAngle =
          -math.pi / 2 + unit * (emptyArcSize + fullArcSize) + emptyArcSize / 2;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: (size.width / 2) - 10,
        ),
        startAngle,
        fullArcSize,
        false,
        paint,
      );
    }
    // final double fontSize = size.width / 2.5;
    // final textSpan = TextSpan(
    //     text: daysRemaining.toString(),
    //     style: TextStyle(
    //       color: GamificationColors.white,
    //       fontSize: fontSize,
    //       fontFamily: 'Impact',
    //     ));
    // final textPainter = TextPainter(
    //   text: textSpan,
    //   textDirection: TextDirection.ltr,
    // )..layout(
    //     minWidth: 0,
    //     maxWidth: size.width,
    //   );
    // final constraints = BoxConstraints(
    //   maxWidth: size.width / 2,
    //   minWidth: 0,
    // );
    // final RenderParagraph renderParagraph = RenderParagraph(
    //   textSpan,
    //   textDirection: ui.TextDirection.ltr,
    //   maxLines: 1,
    // )..layout(constraints);
    // final double textwidth =
    //     renderParagraph.getMinIntrinsicWidth(70).ceilToDouble();
    // final double textheight =
    //     renderParagraph.getMinIntrinsicHeight(70).ceilToDouble();
    // final offset = Offset(
    //     size.width / 2 - textwidth / 2, size.height / 2 - textheight / 2);
    // textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CircularCountdownPainter oldDelegate) => false;
}
