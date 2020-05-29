import 'package:flutter/material.dart';

class DeleteFunction {
  String item;
  Function spinnerCallback;
  Function todo;
  DeleteFunction(this.item, this.todo, this.spinnerCallback);

  void showDialogBox(BuildContext context, String id) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text('Are you sure you want to Delete this $item?'),
            title: Text(
              'Delete $item',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                onPressed: () {
                  spinnerCallback(true);
                  todo(id);
                  spinnerCallback(false);
                  Navigator.pop(context);
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
