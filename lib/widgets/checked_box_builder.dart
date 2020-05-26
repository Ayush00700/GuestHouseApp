import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/floor_data.dart';
import 'package:guesthouseapp/screens/new_account.dart';
import 'package:guesthouseapp/models/floor.dart';
import 'package:provider/provider.dart';

class BuildCheckedBox extends StatelessWidget {
  final Floor currentFloor;
  BuildCheckedBox(this.currentFloor);

  @override
  Widget build(BuildContext context) {
    return Consumer<FloorData>(
      builder: (context, floorData, child) {
        return Flexible(
          child: Container(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: NewAccount.dateDifference.inDays + 1,
              itemBuilder: (BuildContext context, int index) {
                return Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Checkbox(
                        activeColor: Theme.of(context).accentColor,
                        value: currentFloor.selectedDates[index],
                        // value: widget.floorDaysCount[index],
                        onChanged: (value) {
                          floorData.selectedDatesPerFloor(
                              currentFloor.name, value, index);
                          int counter =
                              floorData.noOfSelectedDates(currentFloor.name);
                          floorData.priceCalculate(currentFloor.name, counter);
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        (NewAccount.newUser.fromDate
                                .add(Duration(days: index))
                                .day)
                            .toString(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
