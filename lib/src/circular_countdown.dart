import 'package:flutter/material.dart';

import 'circular_countdown_painter.dart';

/// A circular countdown.
///
/// Can be used to represent all kind of units (days, hours, points, ...) that could be decremented
class CircularCountdown extends StatelessWidget {
  /// Creates a Circular Countdown.
  ///
  /// * [diameter] determines the size of the widget.
  /// * [countdownTotal] is the total amount of units.
  /// * [countdownRemaining] is the amount of remaining units.
  ///
  /// You can override some of the colors with the [countdownTotalColor] and
  /// [countdownRemainingColor] properties.
  /// A color for the current unit can be set with the [countdownCurrentColor].
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// CircularCountdown(
  ///   diameter: 250,
  ///   countdownTotal: 10,
  ///   countdownRemaining: 3,
  /// ),
  /// ```
  /// {@end-tool}
  const CircularCountdown({
    Key key,
    @required this.diameter,
    @required this.countdownTotal,
    @required this.countdownRemaining,
    this.countdownTotalColor = Colors.white30,
    this.countdownRemainingColor = Colors.white,
    this.countdownCurrentColor,
    this.gapFactor = 6,
    this.strokeWidth,
  })  : assert(diameter != null && diameter > 0.0),
        assert(countdownTotal != null && countdownTotal > 0.0),
        assert(countdownRemaining != null &&
            countdownRemaining >= 0.0 &&
            countdownRemaining <= countdownTotal),
        assert(gapFactor > 0.0),
        super(key: key);

  /// The outer diameter of the circular countdown widget.
  final double diameter;

  /// The total amount of units.
  final int countdownTotal;

  /// The amount of remaining units.
  final int countdownRemaining;

  /// The color to use when painting passed units.
  ///
  /// Defaults to [Colors.white30].
  final Color countdownTotalColor;

  /// The color to use when painting remaining units.
  ///
  /// Defaults to [Colors.white].
  final Color countdownRemainingColor;

  /// The color to use when painting passed units.
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

  @override
  Widget build(BuildContext context) {
    double paintStrokeWidth =
        (strokeWidth != null && strokeWidth > 0 && strokeWidth <= diameter / 2)
            ? strokeWidth
            : diameter / 6;
    return CustomPaint(
      painter: CircularCountdownPainter(
          countdownTotal: countdownTotal,
          countdownRemaining: countdownRemaining,
          countdownTotalColor: countdownTotalColor,
          countdownRemainingColor: countdownRemainingColor,
          countdownCurrentColor: countdownCurrentColor,
          gapFactor: gapFactor,
          strokeWidth: paintStrokeWidth),
      size: Size(diameter - paintStrokeWidth, diameter - paintStrokeWidth),
    );
  }
}
