import 'package:flutter/material.dart';
import 'package:gameon_tech/extra_icons.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Dates('3', 'Sun'),
            const Dates('4', 'Mon'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Jan',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '05',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Tue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Dates('6', 'Wed'),
            const Dates('7', 'Thu'),
            const Dates('8', 'Fri'),
          ],
        ),
        const Place(),
        const Line(),
      ],
    );
  }
}

class Dates extends StatelessWidget {
  final String date;
  final String day;
  const Dates(this.date, this.day, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Jan',
          style: TextStyle(fontSize: 13),
        ),
        Text(
          '0$date',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          day,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

class Place extends StatelessWidget {
  const Place({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
        right: 20,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Extra.location,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              const SizedBox(
                width: 3,
              ),
              const Text(
                'Maharashtra, India',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                'Change',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Theme.of(context).primaryColor,
                size: 12,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 14,
      ),
      height: 1,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffE7E7E7))),
    );
  }
}
