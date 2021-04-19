import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'circular_countdown.dart';

/// Signature for a function which takes the `unit` and the `remaining` countdown.
typedef CountdownCallback = void Function(
  CountdownUnit unit,
  int remaining,
);

/// Time unit `CircularCountdown`.
///
/// Refreshes itself every `unit` tick.
class TimeCircularCountdown extends StatefulWidget {
  /// Creates a [TimeCircularCountdown].
  const TimeCircularCountdown({
    @required this.unit,
    this.countdownTotal = 1,
    this.shouldDowngradeUnit = true,
    this.onUpdated,
    this.onFinished,
    this.onCanceled,
    this.diameter,
    this.countdownTotalColor,
    this.countdownRemainingColor,
    this.countdownCurrentColor,
    this.gapFactor,
    this.strokeWidth,
    this.textStyle,
    this.isClockwise,
    this.repeat,
    Key key,
  })  : assert(countdownTotal != null && countdownTotal > 0),
        assert(unit != null),
        assert(gapFactor == null || gapFactor > 0.0),
        super(key: key);

  /// The time unit.
  final CountdownUnit unit;

  /// The amount of unit to count down.
  ///
  /// Default to `1`.
  final int countdownTotal;

  /// If the countdown should display the unit below
  /// when less than a unit left.
  ///
  /// Default to `true`.
  final bool shouldDowngradeUnit;

  /// Callback to call when countdown has updated.
  final CountdownCallback onUpdated;

  /// Callback to call when countdown has finished.
  final VoidCallback onFinished;

  /// Callback to call when countdown has canceled before the end.
  final CountdownCallback onCanceled;

  /// The outer diameter of the circular countdown widget.
  ///
  /// Default to max available if possible, else `100`.
  final double diameter;

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
  ///
  /// Default to [true].
  final bool isClockwise;

  /// Whether the countdown should restart when finished or not.
  ///
  /// Default to [false].
  final bool repeat;

  /// The `TextStyle` to use to display the `countdownRemaining` value
  /// in the center of the widget.
  ///
  /// Warning : It will not displays if the `TextStyle.fontSize` is too large.
  final TextStyle textStyle;

  @override
  _TimeCircularCountdownState createState() => _TimeCircularCountdownState();
}

class _TimeCircularCountdownState extends State<TimeCircularCountdown> {
  Timer timer;
  CountdownUnit unit;
  int timeToEnd;
  int total;

  static const _oneHourInMinutes = 60;
  static const _oneMinuteInSeconds = 60;

  @override
  void initState() {
    super.initState();
    unit = widget.unit;
    total = widget.countdownTotal;
    timeToEnd = widget.countdownTotal;
    _updateUnit();
  }

  @override
  void dispose() {
    timer?.cancel();
    if (widget.onCanceled != null && unit != null) {
      widget.onCanceled(unit, timeToEnd);
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(TimeCircularCountdown old) {
    if (widget.countdownTotal != old.countdownTotal ||
        widget.unit != old.unit) {
      timer?.cancel();
      unit = widget.unit;
      total = widget.countdownTotal;
      timeToEnd = widget.countdownTotal;
      _updateUnit();
    }
    super.didUpdateWidget(old);
  }

  void _updateUnit() {
    if (timeToEnd == 1) {
      if (widget.shouldDowngradeUnit) {
        switch (unit) {
          case CountdownUnit.hour:
            unit = CountdownUnit.minute;
            timeToEnd = _oneHourInMinutes;
            total = _oneHourInMinutes;
            break;
          case CountdownUnit.minute:
            unit = CountdownUnit.second;
            timeToEnd = _oneMinuteInSeconds;
            total = _oneMinuteInSeconds;
            break;
          default:
        }
      }
    } else if (timeToEnd == 0) {
      unit = null;
    }
    switch (unit) {
      case CountdownUnit.hour:
        timer = Timer(
          const Duration(hours: 1),
          _updateTime,
        );
        break;
      case CountdownUnit.minute:
        timer = Timer(
          const Duration(minutes: 1),
          _updateTime,
        );
        break;
      case CountdownUnit.second:
        timer = Timer(
          const Duration(seconds: 1),
          _updateTime,
        );
        break;
      default:
        timer?.cancel();
        if (widget.onFinished != null) {
          widget.onFinished();
        }
        if (widget.repeat != null && widget.repeat) {
          unit = widget.unit;
          total = widget.countdownTotal;
          timeToEnd = widget.countdownTotal;
          _updateUnit();
        }
    }
    if (widget.onUpdated != null && unit != null) {
      Future.microtask(() => widget.onUpdated(unit, timeToEnd));
    }
  }

  void _updateTime() {
    setState(() {
      timeToEnd--;
      _updateUnit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircularCountdown(
      countdownTotal: total,
      countdownRemaining: timeToEnd,
      diameter: widget.diameter,
      countdownTotalColor: widget.countdownTotalColor,
      countdownRemainingColor: widget.countdownRemainingColor,
      countdownCurrentColor: widget.countdownCurrentColor,
      gapFactor: widget.gapFactor,
      strokeWidth: widget.strokeWidth,
      textStyle: widget.textStyle,
      isClockwise: widget.isClockwise,
    );
  }
}

/// Describes the time countdown unit available.
enum CountdownUnit {
  /// Hour unit.
  hour,

  /// Minute unit.
  minute,

  /// Second unit.
  second,
}
