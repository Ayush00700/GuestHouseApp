import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/widgets/admin_list.dart';

class DashBoardScreen extends StatelessWidget {
  Admin currentAdmin;
  DashBoardScreen();
  @override
  Widget build(BuildContext context) {
    currentAdmin = AdminBuilder.currentAdmin;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              // gradient: LinearGradient(colors: [Colors.black, Colors.teal]),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(80.0),
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'DASHBOARD',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                          fontSize: 40.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.account_circle,
                  size: 80.0,
                  color: Colors.white,
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 10,
                // ),
                Text(
                  'Welcome ${currentAdmin.name}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                      fontSize: 40.0),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Add New Booking',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    leading: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).accentColor,
                      size: 30.0,
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Theme.of(context).accentColor,
                      size: 30.0,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    onTap: () {
                      Navigator.pushNamed(context, '/newacc');
                    },
                  ),
                  ListTile(
                    title: Text(
                      'View Current Bookings',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    leading: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).accentColor,
                      size: 30.0,
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 30.0,
                      color: Theme.of(context).accentColor,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    onTap: () {},
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
