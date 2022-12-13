import 'package:flutter/material.dart';

class CardMiddle extends StatelessWidget {
  const CardMiddle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Column1(
          'Team 1:',
          'Mumbai Indians',
          'Booked',
          0xff111010,
        ),
        SizedBox(
          width: 88,
        ),
        Column1(
          'Team 2:',
          'Available',
          'Available',
          0xff088F81,
        ),
      ],
    );
  }
}

class Column1 extends StatelessWidget {
  final String t1;
  final String t2;
  final String t3;
  final int t4;
  const Column1(this.t1, this.t2, this.t3, this.t4, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t1,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff7FA89C),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          t2,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(t4).withOpacity(0.1),
          ),
          child: Text(
            t3,
            style: TextStyle(fontSize: 12, color: Color(t4)),
          ),
        ),
      ],
    );
  }
}
