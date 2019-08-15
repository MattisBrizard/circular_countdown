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
    @required this.countdownTotalColor,
    @required this.countdownRemainingColor,
    @required this.strokeWidth,
    @required this.gapFactor,
    this.countdownCurrentColor,
    this.textSpan,
  });

  final int countdownTotal;
  final int countdownRemaining;
  final Color countdownTotalColor;
  final Color countdownRemainingColor;
  final double gapFactor;
  final double strokeWidth;
  final Color countdownCurrentColor;
  final TextSpan textSpan;

  Paint get totalPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = countdownTotalColor;

  Paint get remainingPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = countdownRemainingColor;

  Paint get currentPaint {
    if (countdownCurrentColor != null) {
      return Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = countdownCurrentColor;
    } else {
      return null;
    }
  }

  double get emptyArcSize => 2 * math.pi / (gapFactor * countdownTotal);
  double get fullArcSize => 2 * math.pi / countdownTotal - emptyArcSize;
  double startAngle(int unit) =>
      -math.pi / 2 + unit * (emptyArcSize + fullArcSize) + emptyArcSize / 2;
  double getInnerRadius(double width) {
    final double _radius = width - 2 * strokeWidth;
    return (_radius > 0) ? _radius : 0;
  }

  @override
  void paint(Canvas canvas, Size size) {
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
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
        startAngle(unit),
        fullArcSize,
        false,
        paint,
      );
    }

    // Draws the textSpan (if exists) in the middle of the widget if there is enough space
    if (textSpan != null) {
      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(
          minWidth: getInnerRadius(size.width),
          maxWidth: getInnerRadius(size.width),
        );
      final BoxConstraints constraints = BoxConstraints(
        maxWidth: getInnerRadius(size.width),
        minWidth: 0,
        maxHeight: getInnerRadius(size.width),
        minHeight: 0,
      );
      final RenderParagraph renderParagraph = RenderParagraph(
        textSpan,
        textDirection: TextDirection.ltr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      )..layout(constraints);
      final double textWidth =
          renderParagraph.getMinIntrinsicWidth(size.width / 2).ceilToDouble();
      final double textHeight =
          renderParagraph.getMinIntrinsicHeight(size.width / 2).ceilToDouble();
      if (textWidth <= getInnerRadius(size.width)) {
        final Offset offset = Offset(
          size.width / 2 - textWidth / 2,
          size.height / 2 - textHeight / 2,
        );
        textPainter.paint(canvas, offset);
      }
    }
  }

  @override
  bool shouldRepaint(CircularCountdownPainter oldDelegate) {
    return countdownTotal != oldDelegate.countdownTotal ||
        countdownRemaining != oldDelegate.countdownRemaining ||
        countdownTotalColor != oldDelegate.countdownTotalColor ||
        countdownRemainingColor != oldDelegate.countdownRemainingColor ||
        countdownCurrentColor != oldDelegate.countdownCurrentColor ||
        gapFactor != oldDelegate.gapFactor ||
        strokeWidth != oldDelegate.strokeWidth ||
        textSpan != oldDelegate.textSpan;
  }
}
