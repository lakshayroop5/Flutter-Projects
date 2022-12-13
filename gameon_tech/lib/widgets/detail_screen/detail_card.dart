import 'package:flutter/material.dart';
import 'package:gameon_tech/widgets/detail_card/card_middle.dart';
import 'package:gameon_tech/widgets/detail_card/detail_card_bottom.dart';

class DetailCard extends StatelessWidget {
  final String overs;
  final String time;
  final String price;
  const DetailCard(this.overs, this.time, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'For $overs over',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$time:00 am',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const CardMiddle(),

            //Line
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 1,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE7E7E7))),
            ),
            DetailCardBottom(price),
          ],
        ),
      ),
    );
  }
}
