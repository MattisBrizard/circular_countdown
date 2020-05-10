import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';

class TimeCountdownPage extends StatefulWidget {
  @override
  _TimeCountdownPageState createState() => _TimeCountdownPageState();
}

class _TimeCountdownPageState extends State<TimeCountdownPage> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time CountdownPage'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TimeCircularCountdown(
              unit: CountdownUnit.second,
              countdownTotal: 15,
              diameter: 300,
              countdownCurrentColor: Colors.amber,
              onUpdated: (unit, remainingTime) {
                setState(() {
                  description = 'Updated: ${_formatTime(unit, remainingTime)}';
                });
              },
              onFinished: () {
                description = 'Finished';
                setState(() {});
              },
              onCanceled: (unit, remainingTime) => print(
                'Canceled at ${_formatTime(unit, remainingTime)}',
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 90,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(CountdownUnit unit, int remainingTime) =>
      '$remainingTime ${describeEnum(unit)}${remainingTime > 1 ? 's' : ''}';
}
