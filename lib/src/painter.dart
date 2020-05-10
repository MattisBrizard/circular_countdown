import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Painter that draws the circular countdown.
class CircularCountdownPainter extends CustomPainter {
  /// Creates a [CircularCountdownPainter].
  const CircularCountdownPainter({
    @required this.countdownTotal,
    @required this.countdownRemaining,
    @required this.countdownTotalColor,
    @required this.countdownRemainingColor,
    @required this.strokeWidth,
    @required this.gapFactor,
    this.countdownCurrentColor,
    this.textStyle,
  });

  final int countdownTotal;
  final int countdownRemaining;
  final Color countdownTotalColor;
  final Color countdownRemainingColor;
  final double gapFactor;
  final double strokeWidth;
  final Color countdownCurrentColor;
  final TextStyle textStyle;

  Paint get _totalPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = countdownTotalColor;

  Paint get _remainingPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = countdownRemainingColor;

  Paint get _currentPaint {
    if (countdownCurrentColor != null) {
      return Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = countdownCurrentColor;
    } else {
      return null;
    }
  }

  double get _emptyArcSize => 2 * math.pi / (gapFactor * countdownTotal);
  double get _fullArcSize => 2 * math.pi / countdownTotal - _emptyArcSize;
  double _startAngle(int unit) =>
      -math.pi / 2 + unit * (_emptyArcSize + _fullArcSize) + _emptyArcSize / 2;

  double _getInnerDiameter(double width) =>
      math.max(0, width - 2 * strokeWidth);
  double _getRadius(double width) => math.max(0, width / 2 - strokeWidth / 2);

  @override
  void paint(Canvas canvas, Size size) {
    ui.Paint paint;
    for (int unit = 0; unit < countdownTotal; unit++) {
      // Set painter.
      if (_currentPaint != null) {
        if (countdownTotal - unit < countdownRemaining) {
          paint = _remainingPaint;
        } else if (countdownTotal - unit == countdownRemaining) {
          paint = _currentPaint;
        } else {
          paint = _totalPaint;
        }
      } else {
        if (countdownTotal - unit <= countdownRemaining) {
          paint = _remainingPaint;
        } else {
          paint = _totalPaint;
        }
      }

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: _getRadius(size.width),
        ),
        _startAngle(unit),
        _fullArcSize,
        false,
        paint,
      );
    }

    // Draws the current value in the middle of the widget
    // if there is enough space.
    if (textStyle != null) {
      final _innerDiameter = _getInnerDiameter(size.width);
      final text = TextSpan(
        text: countdownRemaining.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(
          minWidth: _innerDiameter,
          maxWidth: _innerDiameter,
        );
      final BoxConstraints constraints = BoxConstraints(
        maxWidth: _innerDiameter,
        maxHeight: _innerDiameter,
      );
      final RenderParagraph renderParagraph = RenderParagraph(
        text,
        textDirection: TextDirection.ltr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      )..layout(constraints);
      final double textWidth =
          renderParagraph.getMinIntrinsicWidth(size.width / 2).ceilToDouble();
      final double textHeight =
          renderParagraph.getMinIntrinsicHeight(size.width / 2).ceilToDouble();
      if (textWidth <= _innerDiameter) {
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
        textStyle != oldDelegate.textStyle;
  }
}
