import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String routeName;
  final String title;
// ignore: use_key_in_widget_constructors
  const AddButton(this.routeName, this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName, arguments: title);
      },
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        maxRadius: 30,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
