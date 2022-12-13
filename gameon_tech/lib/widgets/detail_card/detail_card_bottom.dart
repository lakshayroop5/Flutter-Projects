import 'package:flutter/material.dart';

class DetailCardBottom extends StatelessWidget {
  final String price;
  const DetailCardBottom(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Detail1(
              'Ball provided',
              Icon(
                Icons.check,
                color: Color(0xff088F81),
                size: 14,
              ),
            ),
            Detail1('Umpire provided', Container()),
            const Detail2(),
          ],
        ),
        LastRow(price),
      ],
    );
  }
}

class Detail1 extends StatelessWidget {
  final String title;
  final Widget icon;
  const Detail1(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: const Color(0xffF4F4F4),
            border: Border.all(
              color: const Color(0xffE7E7E7),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: icon,
        ),
      ],
    );
  }
}

class Detail2 extends StatelessWidget {
  const Detail2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'Ball Detail',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          'Tennis',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xff088F81),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class LastRow extends StatelessWidget {
  final String price;
  const LastRow(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            price,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ]));
  }
}
