import 'package:flutter/material.dart';

class PaymentModeChip extends StatelessWidget {
  final bool selected;
  final String name;
  final Function onPressedCallback;
  PaymentModeChip(this.selected, this.name, this.onPressedCallback);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11.0),
        child: Material(
          color: Theme.of(context).primaryColor,
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    value: selected,
                    onChanged: onPressedCallback),
                Text(
                  name,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
