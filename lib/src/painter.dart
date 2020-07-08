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
    @required this.isClockwise,
    this.countdownCurrentColor,
    this.textStyle,
  });

  /// The total amount of units.
  final int countdownTotal;

  /// The amount of remaining units.
  final int countdownRemaining;

  /// The color to use when painting passed units.
  final Color countdownTotalColor;

  /// The color to use when painting remaining units.
  final Color countdownRemainingColor;

  /// The color to use when painting the current unit.
  final Color countdownCurrentColor;

  /// The part of the circle that will be gap. (`1/gapFactor`)
  ///
  /// Example : `gapFactor: 2` means that 50% of the circle will be gaps.
  final double gapFactor;

  /// The thickness of the circle in logical pixels.
  final double strokeWidth;

  /// Whether the countdown is drawn clockwise or not.
  final bool isClockwise;

  /// The `TextStyle` to use to display the `countdownRemaining` value
  /// in the center of the widget.
  ///
  /// Warning : It will not displays if the `TextStyle.fontSize` is too large.
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
    final offset = Offset(size.width / 2, size.height / 2);
    final radius = _getRadius(size.width);
    final arcSize = _fullArcSize;

    ui.Paint paint;
    for (int unit = 0; unit < countdownTotal; unit++) {
      // Set painter.

      if (isClockwise) {
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
      } else {
        if (_currentPaint != null) {
          if (unit + 1 < countdownRemaining) {
            paint = _remainingPaint;
          } else if (unit + 1 == countdownRemaining) {
            paint = _currentPaint;
          } else {
            paint = _totalPaint;
          }
        } else {
          if (unit < countdownRemaining) {
            paint = _remainingPaint;
          } else {
            paint = _totalPaint;
          }
        }
      }

      canvas.drawArc(
        Rect.fromCircle(
          center: offset,
          radius: radius,
        ),
        _startAngle(unit),
        arcSize,
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
