import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/screens/new_account.dart';
import 'package:guesthouseapp/screens/current_bookings_screen.dart';

class DashBoardScreen extends StatelessWidget {
  final Admin currentAdmin;
  DashBoardScreen(this.currentAdmin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'DASHBOARD',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                          fontSize: 40.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Icon(
                  Icons.account_circle,
                  size: 80.0,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 10,
                // ),
                Text(
                  'Welcome ${currentAdmin.name}',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                      fontSize: 35.0),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NewAccount(currentAdmin);
                          },
                        ),
                      );
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CurrentBookingScreen(currentAdmin);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
