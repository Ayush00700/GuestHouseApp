import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/models/data.dart';
import 'package:guesthouseapp/widgets/add_new_admin.dart';
// import 'package:guesthouseapp/widgets/add_new_admin.dart';
import 'package:guesthouseapp/widgets/admin_list.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Data.basicUsers();
  }

  void newAdminAdded(String name) {
    setState(() {
      Data.admins.add(Admin(name: name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
              ),
              iconSize: 30,
              tooltip: 'New User',
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        AddNewAdmin(newAdminCallback: newAdminAdded));
              },
            ),
          )
        ],
      ),
      body: AdminBuilder(),
    );
  }
}
