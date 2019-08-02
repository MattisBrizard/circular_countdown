# circular_countdown

An implementation of a circular countdown.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  circular_countdown: ^0.0.1
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
	diameter:  250,
	countdownTotal:  10,
	countdownRemaining:  7,
)
...
```

<img width="535" height="950" src="https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/images/static.png">

By changing with the parameters, you can change the size, the colors, the size of the gaps and the strokeWidth.
<img width="535" height="950" src="https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/images/complex.png">

Starting from this you can create animated countdown (see how in example).
![Overview](https://raw.githubusercontent.com/MattisBrizard/circular_countdown/master/doc/images/animated_countdown.gif)
