import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/floor_data.dart';
import 'checked_box_builder.dart';
import 'package:provider/provider.dart';
import 'package:guesthouseapp/models/floor.dart';

class FloorBuilder extends StatelessWidget {
  final Floor currentFloor;
  final int _floorIndex;
  FloorBuilder(this._floorIndex, this.currentFloor);

  @override
  Widget build(BuildContext context) {
    return Consumer<FloorData>(builder: (context, floorData, child) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 11.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          activeColor: Theme.of(context).accentColor,
                          value: currentFloor.isSelected,
                          onChanged: (value) {
                            floorData.setFloorToggled(_floorIndex);
                            floorData.buildTicks(_floorIndex, value);
                          }),
                      Text(
                        currentFloor.name,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (currentFloor.isSelected) BuildCheckedBox(currentFloor),
            if (currentFloor.isSelected)
              Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Text(
                  '₹ ' + currentFloor.finalPrice.toString(),
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              )
          ],
        ),
      );
    });
  }
}
