import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:guesthouseapp/screens/user_details.dart';
import 'package:guesthouseapp/widgets/floor_chip.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  final User addUser;
  final Function secondaryFuntionCallbackForDetletion;
  UserCard(this.addUser, this.secondaryFuntionCallbackForDetletion);

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
                    addUser.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('From: ' +
                          DateFormat.yMMMMd("en_US").format(addUser.fromDate)),
                      Text('To: ' +
                          DateFormat.yMMMMd("en_US").format(addUser.toDate))
                    ],
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  addUser.floors[0].isSelected
                      ? FloorChip(
                          Icons.looks_one, ' ', Theme.of(context).accentColor)
                      : FloorChip(Icons.looks_one, ' ', Colors.white10),
                  addUser.floors[1].isSelected
                      ? FloorChip(
                          Icons.looks_two, ' ', Theme.of(context).accentColor)
                      : FloorChip(Icons.looks_two, ' ', Colors.white10),
                  addUser.floors[2].isSelected
                      ? FloorChip(
                          Icons.looks_4, ' ', Theme.of(context).accentColor)
                      : FloorChip(Icons.looks_4, ' ', Colors.white10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: (RichText(
                                text: TextSpan(
                                    text: 'Due Amount: ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                              TextSpan(
                                  text: '₹ ' + addUser.finalPrice,
                                  style: TextStyle(color: Colors.green))
                            ]))
                            // 'Due Amount: ' + addUser.finalPrice,
                            ),
                      ),
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
                return UserDetails(addUser);
              },
            ),
          );
        },
        onLongPress: secondaryFuntionCallbackForDetletion);
  }
}
