# [1.0.0] - 10/05/2020

## Added

Added a `TimeCircularCountdown` which provides an easy way to setup a time countdown with the `CircularCountdown`.

```dart
TimeCircularCountdown(
    unit: CountdownUnit.minute,
    countdownTotal: 5,
    onUpdated: (unit, remainingTime) => print('Updated'),
    onFinished: () => print('Countdown finished'),
    onCanceled: (unit, remainingTime) => print('Canceled'),
    textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 90,
    ),
),
```

## Breaking changes :

Updated `CircularCountdown` constructor :

- `textSpan` has been replaced by `textSyle` that will be used to display the current value of the countdown.

## Changes :

- Updated `CircularCountdown` constructor :

  - `diameter` is no longer required. (If not provided then should take either the maximum space if possible or 100)
  - `countdownRemaining` is no longer required.

- Updated README.md

# [0.1.0] - 15/08/2019

Added possibility to display a textSpan in the center of the widget.

This textSpan will displays only if there is enough space.

```dart
CircularCountdown(
    diameter: 250,
    countdownTotal: 10,
    countdownRemaining: 7,
    strokeWidth: 45,
    textSpan: TextSpan(
        text: '7',
        style: TextStyle(
            color: Colors.white,
            fontSize: 90,
        ),
    ),
)
```

# [0.0.2] - 02/08/2019

Updated doc

## [0.0.1] - 02/08/2019

Initial release
