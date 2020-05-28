import 'package:flutter/material.dart';
import 'package:guesthouseapp/screens/new_account.dart';
import 'floor.dart';

class FloorData extends ChangeNotifier {
  String rebate = '0';
  String price = '0';
  Floor floor1 = new Floor(
    name: '1st Floor',
    basePrice: 20000,
    finalPrice: 0,
    selectedDates: new List<bool>(NewAccount.dateDifference.inDays + 1),
    isSelected: false,
  );
  Floor floor2 = new Floor(
    name: '2nd Floor',
    basePrice: 20000,
    finalPrice: 0,
    selectedDates: new List<bool>(NewAccount.dateDifference.inDays + 1),
    isSelected: false,
  );
  Floor floor4 = new Floor(
    name: '4th Floor',
    basePrice: 10000,
    finalPrice: 0,
    isSelected: false,
    selectedDates: new List<bool>(NewAccount.dateDifference.inDays + 1),
  );

  void setRebate(String rebateValue) {
    rebate = rebateValue;
    notifyListeners();
  }

  void setFloorToggled(int index) {
    if (index == 0) {
      floor1.isSelected = !floor1.isSelected;
      if (floor1.isSelected)
        floor1.finalPrice =
            floor1.basePrice * (NewAccount.dateDifference.inDays + 1);
      else
        floor1.finalPrice = 0;
    } else if (index == 1) {
      floor2.isSelected = !floor2.isSelected;
      if (floor2.isSelected)
        floor2.finalPrice =
            floor2.basePrice * (NewAccount.dateDifference.inDays + 1);
      else
        floor2.finalPrice = 0;
    } else {
      floor4.isSelected = !floor4.isSelected;
      if (floor4.isSelected)
        floor4.finalPrice =
            floor4.basePrice * (NewAccount.dateDifference.inDays + 1);
      else
        floor4.finalPrice = 0;
    }
    notifyListeners();
  }

  void buildTicks(int index, bool isSelected) {
    for (int i = 0; i < NewAccount.dateDifference.inDays + 1; i++) {
      if (isSelected == true) {
        if (index == 0)
          floor1.selectedDates[i] = true;
        else if (index == 1)
          floor2.selectedDates[i] = true;
        else if (index == 2) floor4.selectedDates[i] = true;
      } else {
        if (index == 0)
          floor1.selectedDates[i] = false;
        else if (index == 1)
          floor2.selectedDates[i] = false;
        else if (index == 2) floor4.selectedDates[i] = false;
      }
    }
    notifyListeners();
  }

  void selectedDatesPerFloor(String name, bool value, int index) {
    if (name == '1st Floor') {
      floor1.selectedDates[index] = value;
    }
    if (name == '2nd Floor') {
      floor2.selectedDates[index] = value;
    }
    if (name == '4th Floor') {
      floor4.selectedDates[index] = value;
    }
    notifyListeners();
  }

  int noOfSelectedDates(String name) {
    int counter = 0;
    for (int i = 0; i < floor1.selectedDates.length; i++) {
      if (name == '1st Floor') if (floor1.selectedDates[i]) counter++;
      if (name == '2nd Floor') if (floor2.selectedDates[i]) counter++;
      if (name == '4th Floor') if (floor4.selectedDates[i]) counter++;
    }
    return counter;
  }

  void priceCalculate(String name, int counter) {
    if (name == '1st Floor') {
      floor1.finalPrice = floor1.basePrice * counter;
    }
    if (name == '2nd Floor') {
      floor2.finalPrice = floor2.basePrice * counter;
    }
    if (name == '4th Floor') {
      floor4.finalPrice = floor4.basePrice * counter;
    }
    notifyListeners();
  }

  // void buildfloors() {
  //   NewAccount.newUser.floors[0] = floor1;
  //   NewAccount.newUser.floors[1] = floor2;
  //   NewAccount.newUser.floors[2] = floor4;
  //   NewAccount.newUser.price =
  //       (floor1.finalPrice + floor2.finalPrice + floor4.finalPrice).toString();
  //   NewAccount.newUser.rebate = rebate;
  //   NewAccount.newUser.finalPrice = 'defined';
  // }
}
