import 'package:flutter/material.dart';

class FloorChip extends StatelessWidget {
  final IconData avater;
  final String text;
  final Color colorOfIcon;
  FloorChip(this.avater, this.text, this.colorOfIcon);
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      avatar: Icon(
        avater,
        color: colorOfIcon,
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }
}
