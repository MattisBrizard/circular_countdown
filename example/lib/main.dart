import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'countdowns/static_countdown.dart';
import 'countdowns/time_countdown.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Circular Countdown',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

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
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<StaticCountdownPage>(
                  builder: (context) => const StaticCountdownPage(),
                ),
              ),
              child: const Text('Static CircularCountdown'),
            ),
            const Gap(30),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<TimeCountdownPage>(
                  builder: (context) => const TimeCountdownPage(),
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
