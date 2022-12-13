import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            OtpBox(),
            OtpBox(),
            OtpBox(),
            OtpBox(),
          ],
        ),
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  const OtpBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 64,
      width: 64,
      child: TextFormField(
        cursorHeight: 40,
        cursorColor: Theme.of(context).primaryColor,
        style: TextStyle(fontSize: 40, color: Theme.of(context).primaryColor),
        decoration: const InputDecoration(border: InputBorder.none),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        obscureText: true,
        obscuringCharacter: '*',
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
      ),
    );
  }
}
