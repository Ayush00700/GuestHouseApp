import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewAdmin extends StatefulWidget {
  // final Function newAdminCallback;
  // AddNewAdmin({this.newAdminCallback});//Uplifting state
  @override
  _AddNewAdminState createState() => _AddNewAdminState();
}

class _AddNewAdminState extends State<AddNewAdmin> {
  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.account_circle,
              size: 50.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 25.0),
          Text(
            'ADD NEW USER',
            style: TextStyle(
                fontSize: 30.0,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                onChanged: (value) {
                  name = value;
                }),
          ),
          SizedBox(height: 25.0),
          RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                DocumentReference reference = Firestore.instance
                    .document("admins/" + DateTime.now().toString());
                reference.setData({'name': name});
                // widget.newAdminCallback(name);   //Uplifting of State
                Navigator.pop(context);
              },
              child: Text(
                'Register',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
