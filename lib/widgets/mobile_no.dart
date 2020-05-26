import 'package:flutter/material.dart';
import 'package:guesthouseapp/screens/new_account.dart';

class MobileNoRow extends StatefulWidget {
  final String _hint;
  MobileNoRow(this._hint);
  @override
  _MobileNoRowState createState() => _MobileNoRowState();
}

class _MobileNoRowState extends State<MobileNoRow> {
  String no;
  bool _isSelf = true;
  Widget checkerforDevice(bool isChecked, String hint) {
    return isChecked
        ? Expanded(
            flex: 1,
            child: Text(
              'Self',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        : Expanded(
            flex: 3,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'Name'),
              onChanged: (value) {
                setState(() {
                  if (hint == 'Mobile No')
                    NewAccount.newUser.mobileNoName = value;
                  else
                    NewAccount.newUser.mobileNoAltName = value;
                });
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: widget._hint, prefixIcon: Icon(Icons.phone)),
              onChanged: (value) {
                if (widget._hint == 'Mobile No')
                  NewAccount.newUser.mobileNo = value;
                else
                  NewAccount.newUser.mobileNoAlt = value;
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Checkbox(
              value: _isSelf,
              activeColor: Theme.of(context).accentColor,
              onChanged: (value) {
                setState(() {
                  _isSelf = value;
                });
              },
            ),
          ),
          checkerforDevice(_isSelf, widget._hint),
        ]);
  }
}
