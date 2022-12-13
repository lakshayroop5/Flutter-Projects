import 'package:flutter/material.dart';
import 'dart:async';

class OtpTimer extends StatefulWidget {
  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late Timer _timer;

  int _start = 59;

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time_filled,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "00:$_start",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
