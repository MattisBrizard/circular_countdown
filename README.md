# circular_countdown

A package that represents a circular countdown that you can use for every kind of units (days, hours, seconds, points, ...) that could be decremented.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  circular_countdown: ^1.1.1
```

In your library add the following import:

```dart
import  'package:circular_countdown/circular_countdown.dart';
```

## Static countdown

This is the way to create a simple static countdown.

```dart
import 'package:flutter/material.dart';
...
CircularCountdown(
	countdownTotal:  10,
	countdownRemaining:  7,
)
...
```

<img width="250"  src="https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/images/static.png">

By playing with the parameters, you can change the size, the colors, the size of the gaps, the strokeWidth and more to have more complex Countdowns.

<img width="250"  src="https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/images/complex.png">

## Timer countdown

If you want to use the `CircularCountdown` widget as a Time Countdown, you can use the built-in `TimeCircularCountdown` that wraps the timer logic for you: (see how in example)

```dart
TimeCircularCountdown(
    unit: CountdownUnit.seconds,
    countdownTotal: 30,
    onUpdated: (unit, remainingTime) => print('Updated'),
    onFinished: () => print('Countdown finished'),
);
```

<img width="250"  src="https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/gifs/timer.gif">

## Demo

A web demo is available here : https://mattisbrizard.github.io/circular_countdown/#/

[![Build Status](https://img.shields.io/github/workflow/status/MattisBrizard/circular_countdown/Deploy%20Flutter%20web)](https://github.com/MattisBrizard/circular_countdown/actions?query=workflow%3A%22Deploy+Flutter+web%22)

## Contribution

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/MattisBrizard/circular_countdown/issues).
If you fixed a bug or implemented a feature, please send a pull [request](https://github.com/MattisBrizard/circular_countdown/pulls).
