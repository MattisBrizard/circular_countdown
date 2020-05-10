import 'package:flutter/material.dart';

import 'countdowns/static_countdown.dart';
import 'countdowns/time_countdown.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Countdown',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CircularCountdown Example'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<StaticCountdownPage>(
                  builder: (context) => StaticCountdownPage(),
                ),
              ),
              child: const Text('Static CircularCountdown'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<TimeCountdownPage>(
                  builder: (context) => TimeCountdownPage(),
                ),
              ),
              child: const Text('Time CircularCountdown'),
            ),
          ],
        ),
      ),
    );
  }
}
