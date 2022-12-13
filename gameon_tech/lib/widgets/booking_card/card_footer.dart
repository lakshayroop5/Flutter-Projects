import 'package:flutter/material.dart';
import 'package:gameon_tech/data/stadiums.dart';
import 'package:gameon_tech/extra_icons.dart';
import 'package:gameon_tech/my_flutter_app_icons.dart';

class CardFooter extends StatelessWidget {
  final Stadium stadium;
  const CardFooter(this.stadium, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stadium.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            const Icon(
              Extra.location,
              size: 18,
              color: Color(0xff868686),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              stadium.city,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff868686),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          height: 1,
          decoration:
              BoxDecoration(border: Border.all(color: const Color(0xffE7E7E7))),
        ),
        Row(
          children: [
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
            const SizedBox(
              width: 120,
            ),
            Row(
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
          ],
        )
      ],
    );
  }
}
