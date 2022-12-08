import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Widget widget;
  final String project;
  const AddButton(this.widget, this.project, {super.key});

  void _startAddVariable(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 40,
      child: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () => _startAddVariable(context),
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}
