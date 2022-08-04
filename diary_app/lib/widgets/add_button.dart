import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String routeName;
// ignore: use_key_in_widget_constructors
  const AddButton(this.routeName);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
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
