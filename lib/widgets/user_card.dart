import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:guesthouseapp/screens/user_details.dart';
import 'package:intl/intl.dart';

class UserCard extends StatefulWidget {
  final User addUser;
  UserCard(this.addUser);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.fromLTRB(20, 10, 15, 0),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20.0),
            border: Border.all(width: 0.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.addUser.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('From: ' +
                        DateFormat.yMMMMd("en_US")
                            .format(widget.addUser.fromDate)),
                    Text('To: ' +
                        DateFormat.yMMMMd("en_US")
                            .format(widget.addUser.toDate))
                  ],
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // if (addUser.floors[0].isSelected) Chip(label: Text('1st Floor')),
                // if (addUser.floors[1].isSelected) Chip(label: Text('2nd Floor')),
                // if (addUser.floors[2].isSelected) Chip(label: Text('4th Floor')),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: (RichText(
                          text: TextSpan(
                              text: 'Due Amount: ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                        TextSpan(
                            text: widget.addUser.finalPrice,
                            style: TextStyle(color: Colors.green))
                      ]))
                      // 'Due Amount: ' + addUser.finalPrice,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserDetails(widget.addUser);
            },
          ),
        );
      },
    );
  }
  //     onLongPress: () {
  //       deletion();
  //     },
  //   );
  // }

  // void deletion() async {
  //   await Firestore.instance
  //       .collection('users')
  //       .document(widget.addUser.fromDate.toString())
  //       .delete();
  //   setState(() {});
  // }
}
