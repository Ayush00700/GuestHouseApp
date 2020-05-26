import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/models/data.dart';

class AdminBuilder extends StatefulWidget {
  static Admin currentAdmin = new Admin();

  @override
  _AdminBuilderState createState() => _AdminBuilderState();
}

class _AdminBuilderState extends State<AdminBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Data.admins.length,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          child: ListTile(
            title: Text(
              Data.admins[index].name,
              style: TextStyle(fontSize: 20.0),
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
            onTap: () {
              AdminBuilder.currentAdmin = Data.admins[index];
              Navigator.pushNamed(context, '/dashboard');
            },
            trailing: Icon(
              Icons.navigate_next,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
