# [1.1.1] - 08/07/2020

## Changes :

- Fixed an issue where isClockwise wasn't correctly used.

# [1.1.0] - 08/07/2020

## Changes :

- Added a isClockwise property to draw the countdown clockwise or not.

# [1.0.2] - 28/06/2020

## Changes :

- Added timer gif in Readme.

# [1.0.1] - 14/05/2020

## Changes :

- Updated Documentation.

# [1.0.0] - 10/05/2020

## Added :

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
);
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