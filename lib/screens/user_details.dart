import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:guesthouseapp/widgets/dates_display.dart';

class UserDetails extends StatelessWidget {
  final User currentUser;
  UserDetails(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(80.0),
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      currentUser.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          fontSize: 20.0),
                    ),
                    Chip(
                      backgroundColor: Theme.of(context).canvasColor,
                      label: (RichText(
                          text: TextSpan(
                              text: 'Due Amount: ',
                              children: <TextSpan>[
                            TextSpan(
                                text: currentUser.finalPrice,
                                style: TextStyle(color: Colors.green))
                          ]))),
                    ),
                  ],
                ),
                if ((currentUser.floors[0].isSelected))
                  DatesDisplay(
                      currentUser,
                      Icon(
                        Icons.looks_one,
                      ),
                      0),
                if ((currentUser.floors[1].isSelected))
                  DatesDisplay(
                      currentUser,
                      Icon(
                        Icons.looks_two,
                      ),
                      1),
                if ((currentUser.floors[2].isSelected))
                  DatesDisplay(currentUser, Icon(Icons.looks_3), 2),
                Text(
                  'Added By: ' + currentUser.addedBy.name,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 10.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Contact Details',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.green),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(currentUser.mobileNoName + ': ' + currentUser.mobileNo),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
                currentUser.mobileNoAltName + ': ' + currentUser.mobileNoAlt),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Address',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.green),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(currentUser.addressL1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(currentUser.addressL2),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Payment',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.green),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text('Initial Price: ' + currentUser.price),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              'Rebate Provided: ' + currentUser.rebate,
            ),
          ),
        ],
      ),
    );
  }
}
