# circular_countdown

A package that represents a circular countdown that you can use for every kind of units (days, hours, seconds, points, ...) that could be decremented.

## Getting Started

The latest version is [![Pub](https://img.shields.io/pub/v/circular_countdown.svg)](https://pub.dev/packages/circular_countdown).

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  circular_countdown: ^latest_version
```

In your library add the following import:

```dart
import  'package:circular_countdown/circular_countdown.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Example

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

By playing with the parameters, you can change the size, the colors, the size of the gaps and the strokeWidth.

<img width="250"  src="https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/images/complex.png">

## Demo

A web demo is available here : https://mattisbrizard.github.io/countdown_clock/#/

[![Build Status](https://img.shields.io/github/workflow/status/MattisBrizard/circular_countdown/Deploy%20Flutter%20web)](https://github.com/MattisBrizard/circular_countdown/actions?query=workflow%3A%22Deploy+Flutter+web%22)
