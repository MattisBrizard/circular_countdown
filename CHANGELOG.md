## [0.1.0] - 15/08/2019

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

## [0.0.2] - 02/08/2019

Updated doc

## [0.0.1] - 02/08/2019

Initial release
