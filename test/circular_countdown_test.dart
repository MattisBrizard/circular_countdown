import 'package:circular_countdown/src/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CircularCountdown constructor', (WidgetTester tester) async {
    const CircularCountdown countdown = CircularCountdown(
      countdownTotal: 10,
    );

    expect(countdown.countdownTotal, 10);
    expect(countdown.countdownRemaining, null);
    expect(countdown.diameter, null);
    expect(countdown.countdownTotalColor, Colors.white30);
    expect(countdown.countdownRemainingColor, Colors.white);
    expect(countdown.countdownCurrentColor, null);
    expect(countdown.gapFactor, 6);
    expect(countdown.strokeWidth, null);
    expect(countdown.textStyle, null);
    expect(countdown.isClockwise, true);

    const TextStyle style = TextStyle();
    const CircularCountdown countdown2 = CircularCountdown(
      countdownTotal: 10,
      countdownRemaining: 9,
      diameter: 300,
      countdownTotalColor: Colors.amber,
      countdownRemainingColor: Colors.red,
      countdownCurrentColor: Colors.black,
      gapFactor: 2,
      strokeWidth: 30,
      textStyle: style,
    );

    expect(countdown2.countdownTotal, 10);
    expect(countdown2.countdownRemaining, 9);
    expect(countdown2.diameter, 300);
    expect(countdown2.countdownTotalColor, Colors.amber);
    expect(
      countdown2.countdownRemainingColor,
      Colors.red,
    );
    expect(
      countdown2.countdownCurrentColor,
      Colors.black,
    );
    expect(countdown2.gapFactor, 2);
    expect(countdown2.strokeWidth, 30);
    expect(countdown2.textStyle, style);
  });

  testWidgets(
      'CircularCountdown should take available space when diameter not specified',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: CircularCountdown(
            countdownTotal: 10,
          ),
        ),
      ),
    );

    final painterFinder = find.byType(CustomPaint);

    expect(
      painterFinder,
      findsOneWidget,
    );

    final painter = painterFinder.evaluate().first;

    expect(
      painter.size!.width,
      400,
    );
    expect(
      painter.size!.height,
      400,
    );
  });

  testWidgets('CircularCountdown should have diameter size',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: CircularCountdown(
            countdownTotal: 10,
            diameter: 200,
          ),
        ),
      ),
    );

    final painterFinder = find.byType(CustomPaint);

    expect(
      painterFinder,
      findsOneWidget,
    );

    final painter = painterFinder.evaluate().first;

    expect(
      painter.size!.width,
      200,
    );
    expect(
      painter.size!.height,
      200,
    );
  });
}
