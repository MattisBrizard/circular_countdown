import 'dart:math';

import 'package:flutter/material.dart';

import 'painter.dart';

/// A circular countdown.
///
/// Can be used to represent all kind of units (days, hours, points, ...)
/// that could be decremented.
class CircularCountdown extends StatelessWidget {
  /// Creates a [CircularCountdown].
  ///
  /// * [countdownTotal] is the total amount of units.
  ///
  /// By default it will take the available space.
  ///
  /// You can override the colors with the [countdownTotalColor] and
  /// [countdownRemainingColor] properties.
  /// A color for the current unit can be set with the [countdownCurrentColor].
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// CircularCountdown(
  ///   countdownTotal: 10,
  /// );
  /// ```
  /// {@end-tool}
  const CircularCountdown({
    Key key,
    @required this.countdownTotal,
    this.countdownRemaining,
    this.diameter,
    this.countdownTotalColor,
    this.countdownRemainingColor,
    this.countdownCurrentColor,
    this.gapFactor,
    this.strokeWidth,
    this.isClockwise,
    this.textStyle,
  })  : assert(diameter == null || diameter > 0.0),
        assert(countdownTotal != null && countdownTotal > 0.0),
        assert(countdownRemaining == null ||
            (countdownRemaining >= 0.0 &&
                countdownRemaining <= countdownTotal)),
        assert(gapFactor == null || gapFactor > 0.0),
        super(key: key);

  /// The outer diameter of the circular countdown widget.
  ///
  /// Default to max available if possible, else `100`.
  final double diameter;

  /// The total amount of units.
  final int countdownTotal;

  /// The amount of remaining units.
  ///
  /// Default to `countdownTotal`.
  final int countdownRemaining;

  /// The color to use when painting passed units.
  ///
  /// Defaults to [Colors.white30].
  final Color countdownTotalColor;

  /// The color to use when painting remaining units.
  ///
  /// Defaults to [Colors.white].
  final Color countdownRemainingColor;

  /// The color to use when painting the current unit.
  final Color countdownCurrentColor;

  /// The part of the circle that will be gap. (`1/gapFactor`)
  ///
  /// Example : `gapFactor: 2` means that 50% of the circle will be gaps.
  ///
  /// Defaults to [6].
  final double gapFactor;

  /// The thickness of the circle in logical pixels.
  ///
  /// Must be positive and less than [diameter/2].
  ///
  /// Default to [diameter/6] for proportion purpose.
  final double strokeWidth;

  /// Whether the countdown is drawn clockwise or not.
  /// Default to [true].
  final bool isClockwise;

  /// The `TextStyle` to use to display the `countdownRemaining` value
  /// in the center of the widget.
  ///
  /// Warning : It will not displays if the `TextStyle.fontSize` is too large.
  final TextStyle textStyle;

  static const double _fallbackDiameter = 100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double computedDiameter;
        if (diameter == null) {
          final double height = constraints.maxHeight != double.infinity
              ? constraints.maxHeight
              : _fallbackDiameter;

          final double width = constraints.maxWidth != double.infinity
              ? constraints.maxWidth
              : _fallbackDiameter;

          computedDiameter = min(height, width);
        }

        final finalDiameter = diameter ?? computedDiameter;
        final double paintStrokeWidth = (strokeWidth != null &&
                strokeWidth > 0 &&
                strokeWidth <= finalDiameter / 2)
            ? strokeWidth
            : finalDiameter / 6;

        return Center(
          child: CustomPaint(
            painter: CircularCountdownPainter(
              countdownTotal: countdownTotal,
              countdownRemaining: countdownRemaining ?? countdownTotal,
              countdownTotalColor: countdownTotalColor ?? Colors.white30,
              countdownRemainingColor: countdownRemainingColor ?? Colors.white,
              countdownCurrentColor: countdownCurrentColor,
              gapFactor: gapFactor ?? 6,
              strokeWidth: paintStrokeWidth,
              textStyle: textStyle,
              isClockwise: isClockwise ?? true,
            ),
            size: Size(
              finalDiameter,
              finalDiameter,
            ),
          ),
        );
      },
    );
  }
}
