import 'package:flutter/material.dart';
import '../screens/content_grid_screen.dart';

class HomeTile extends StatelessWidget {
  final String title;
  const HomeTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ContentGridScreen.routeName, arguments: title);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 4, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Card(
          color: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(vertical: 0),
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
