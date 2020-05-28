import 'package:flutter/material.dart';
import 'package:guesthouseapp/widgets/add_new_admin.dart';
// import 'package:guesthouseapp/widgets/add_new_admin.dart';
import 'package:guesthouseapp/widgets/admin_list.dart';

class WelcomeScreen extends StatelessWidget {
  // void newAdminAdded(String name) {//Uplifting state with Stateful widget
  //   setState(() {
  //     Data.admins.add(Admin(name: name));
  //   });

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
                    context: context, builder: (context) => AddNewAdmin());
              },
            ),
          )
        ],
      ),
      body: AdminBuilder(),
    );
  }
}
