import 'package:flutter/material.dart';
import 'package:gameon_tech/data/stadiums.dart';
import 'package:gameon_tech/extra_icons.dart';

class DetailHeader extends StatelessWidget {
  final Stadium stadium;
  const DetailHeader(this.stadium, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Extra.calender,
              color: Color(0xff088F81),
              size: 25,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'Sunday, 21 June 2021',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(20),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/wankhede1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          stadium.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Extra.location,
                    color: Color(0xff088F81),
                    size: 18,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Navigate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff088F81),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Pitch type: '),
                    TextSpan(
                      text: 'Mat',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Container1(
                  Icon(
                    Extra.eating,
                    color: Color(0xff088F81),
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container1(
                  Icon(
                    Extra.umpire,
                    color: Color(0xff088F81),
                    size: 25,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xff088F81).withOpacity(0.1),
              ),
              child: Row(
                children: [
                  const Icon(
                    Extra.navigate,
                    color: Color(0xff088F81),
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    stadium.distance,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff088F81),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Container1 extends StatelessWidget {
  final Widget widget;
  const Container1(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff088F81).withOpacity(0.1),
      ),
      child: widget,
    );
  }
}
