import 'package:flutter/material.dart';
import 'package:gameon_tech/screens/booking_screen.dart';
import 'package:gameon_tech/widgets/otp_form.dart';
import 'package:gameon_tech/widgets/otp_timer.dart';

class OptScreen extends StatelessWidget {
  final String number;
  const OptScreen(this.number, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Enter OTP',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const OtpForm(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'OTP send to $number',
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xff7FA89C),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        OtpTimer(),
        const SizedBox(
          height: 65,
        ),
        SizedBox(
          width: 140,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(BookingScreen.routeName);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            child: const Text('Login'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
