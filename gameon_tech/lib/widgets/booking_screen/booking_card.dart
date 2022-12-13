import 'package:flutter/material.dart';
import 'package:gameon_tech/data/stadiums.dart';
import 'package:gameon_tech/screens/detail_screen.dart';
import 'package:gameon_tech/widgets/booking_card/card_footer.dart';
import 'package:gameon_tech/widgets/booking_card/overs.dart';

class BookingCard extends StatelessWidget {
  final Stadium stadium;
  const BookingCard(this.stadium, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: stadium);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 96,
                    height: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(stadium
                            .image), // or Image.asset(stadium.image).image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Overs(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CardFooter(stadium),
            ],
          ),
        ),
      ),
    );
  }
}
