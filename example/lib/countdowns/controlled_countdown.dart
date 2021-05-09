import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timer_controller/timer_controller.dart';

class ControlledCountdownPage extends StatelessWidget {
  const ControlledCountdownPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Controlled CircularCountdown (with timer_controller library)',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: _Countdowns(),
          ),
        ),
      ),
    );
  }
}

class _Countdowns extends StatefulWidget {
  const _Countdowns({
    Key? key,
  }) : super(key: key);

  @override
  __CountdownsState createState() => __CountdownsState();
}

class __CountdownsState extends State<_Countdowns> {
  late final TimerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TimerController.seconds(15);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerControllerListener(
      controller: _controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          _StatusSnackBar(
            'Status: ${describeEnum(timerValue.status)}',
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TimerControllerBuilder(
              controller: _controller,
              builder: (context, timerValue, _) {
                Color? timerColor;
                switch (timerValue.status) {
                  case TimerStatus.running:
                    timerColor = Colors.green;
                    break;
                  case TimerStatus.paused:
                    timerColor = Colors.grey;
                    break;
                  case TimerStatus.finished:
                    timerColor = Colors.red;
                    break;
                  default:
                }

                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 40,
                  runSpacing: 40,
                  children: <Widget>[
                    CircularCountdown(
                      diameter: 250,
                      gapFactor: 2,
                      strokeWidth: 125,
                      countdownTotal: _controller.initialValue.remaining,
                      countdownRemaining: timerValue.remaining,
                      countdownCurrentColor: timerColor,
                    ),
                    CircularCountdown(
                      diameter: 250,
                      countdownTotal: _controller.initialValue.remaining,
                      countdownRemaining: timerValue.remaining,
                      countdownCurrentColor: timerColor,
                      strokeWidth: 5,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 90,
                      ),
                    ),
                    CircularCountdown(
                      diameter: 250,
                      countdownTotal: _controller.initialValue.remaining,
                      countdownRemaining: timerValue.remaining,
                      countdownCurrentColor: timerColor,
                      countdownRemainingColor: const Color(0xFF4F6367),
                      countdownTotalColor: Colors.transparent,
                      textStyle: const TextStyle(
                        color: Color(0xFFFE5F55),
                        fontSize: 90,
                      ),
                    ),
                    CircularCountdown(
                      diameter: 250,
                      countdownTotal: _controller.initialValue.remaining,
                      countdownRemaining: timerValue.remaining,
                      countdownCurrentColor: timerColor,
                    ),
                  ],
                );
              },
            ),
            const Gap(40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _ActionButton(
                  title: 'Start',
                  onPressed: () => _controller.start(),
                ),
                _ActionButton(
                  title: 'Pause',
                  onPressed: () => _controller.pause(),
                ),
                _ActionButton(
                  title: 'Reset',
                  onPressed: () => _controller.reset(),
                ),
                _ActionButton(
                  title: 'Restart',
                  onPressed: () => _controller.restart(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

class _StatusSnackBar extends SnackBar {
  _StatusSnackBar(
    String title,
  ) : super(
          content: Text(title),
          duration: const Duration(seconds: 1),
        );
}
