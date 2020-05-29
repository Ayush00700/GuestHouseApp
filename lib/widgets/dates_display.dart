import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';

class DatesDisplay extends StatelessWidget {
  final User currentUser;
  final Icon avater;
  final int indexed;
  DatesDisplay(this.currentUser, this.avater, this.indexed);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Chip(
            label: Text('Floor'),
            avatar: avater,
            backgroundColor: Theme.of(context).canvasColor,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  currentUser.toDate.difference(currentUser.fromDate).inDays +
                      1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                  child: Text(
                    currentUser.fromDate
                        .add(Duration(days: index))
                        .day
                        .toString(),
                    style: TextStyle(
                        color:
                            (currentUser.floors[indexed].selectedDates[index])
                                ? Colors.green
                                : Colors.white30),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
