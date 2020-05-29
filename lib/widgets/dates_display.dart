import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:guesthouseapp/widgets/floor_chip.dart';

class DatesDisplay extends StatelessWidget {
  final User currentUser;
  final IconData avater;
  final int indexed;
  DatesDisplay(this.currentUser, this.avater, this.indexed);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FloorChip(avater, 'Floor', Theme.of(context).accentColor),
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
