import 'package:flutter/material.dart';
import 'package:guesthouseapp/screens/new_account.dart';
import 'package:guesthouseapp/widgets/floor_builder.dart';
import 'package:provider/provider.dart';
import 'package:guesthouseapp/models/floor_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomSelection extends StatelessWidget {
  final globalKey = GlobalKey<ScaffoldState>();
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FloorData(),
      child: Consumer<FloorData>(builder: (context, floorData, child) {
        return Scaffold(
          key: globalKey,
          appBar: AppBar(
            title: Text('Select Rooms'),
            leading: Icon(Icons.rv_hookup),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Rooms Available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  FloorBuilder(0, floorData.floor1),
                  FloorBuilder(1, floorData.floor2),
                  FloorBuilder(2, floorData.floor4),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.black12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width / 1.4),
                      Text('REBATE : ₹ '),
                      Expanded(
                        child: TextField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              try {
                                int.parse(value);
                                floorData.setRebate(value);
                              } catch (e) {
                                print(e);
                                globalKey.currentState.showSnackBar(
                                  SnackBar(
                                      content: Container(
                                          height: 80.0,
                                          child: Text(
                                            'Rebate should be a number',
                                            textAlign: TextAlign.center,
                                          ))),
                                );
                              }
                            }),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Price before discount:'),
                          Text(
                              '₹ ${floorData.floor1.finalPrice + floorData.floor2.finalPrice + floorData.floor4.finalPrice}'),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Discount: '),
                          Text('₹ ' + floorData.rebate)
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Final Price: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          if (floorData.rebate != '')
                            Text(
                              '₹ ' +
                                  ((floorData.floor1.finalPrice +
                                              floorData.floor2.finalPrice +
                                              floorData.floor4.finalPrice) -
                                          int.parse(floorData.rebate))
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          else
                            Text(
                                '₹ ${floorData.floor1.finalPrice + floorData.floor2.finalPrice + floorData.floor4.finalPrice}')
                        ]),
                  ),
                  SizedBox(height: 80)
                ],
              ),
            ],
          ),
          bottomSheet: Container(
            height: 70.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, -1),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'BACK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Text(
                      'PAY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  onTap: () async {
                    // CircularProgressIndicator(
                    //   backgroundColor: Theme.of(context).accentColor,
                    // );
                    NewAccount.newUser.floors[0] = floorData.floor1;
                    NewAccount.newUser.floors[1] = floorData.floor2;
                    NewAccount.newUser.floors[2] = floorData.floor4;
                    NewAccount.newUser.price = (floorData.floor1.finalPrice +
                            floorData.floor2.finalPrice +
                            floorData.floor4.finalPrice)
                        .toString();
                    NewAccount.newUser.rebate = floorData.rebate;
                    NewAccount.newUser.finalPrice =
                        (int.parse(NewAccount.newUser.price) -
                                int.parse(NewAccount.newUser.rebate))
                            .toString();
                    DocumentReference userReference = _firestore.document(
                        'users/' + NewAccount.newUser.fromDate.toString());
                    List<DocumentReference> floorReferences = [];
                    for (int i = 0; i < NewAccount.newUser.floors.length; i++) {
                      floorReferences.add(_firestore.document('floors/' +
                          NewAccount.newUser.fromDate.toString() +
                          NewAccount.newUser.floors[i].name));
                    }
                    await userReference.setData({
                      'name': NewAccount.newUser.name,
                      'addressl1': NewAccount.newUser.addressL1,
                      'addressl2': NewAccount.newUser.addressL2,
                      'mobileNo': NewAccount.newUser.mobileNo,
                      'mobileNoAlt': NewAccount.newUser.mobileNoAlt,
                      'mobileNoName': NewAccount.newUser.mobileNoName,
                      'mobileNoAltName': NewAccount.newUser.mobileNoAltName,
                      'fromDate': NewAccount.newUser.fromDate,
                      'toDate': NewAccount.newUser.toDate,
                      'remarks': NewAccount.newUser.remarks,
                      'price': NewAccount.newUser.price,
                      'rebate': NewAccount.newUser.rebate,
                      'finalPrice': NewAccount.newUser.finalPrice,
                      'createdBy': NewAccount.newUser.addedBy.name,
                      'floors': floorReferences,
                    });
                    for (int i = 0; i < NewAccount.newUser.floors.length; i++) {
                      await floorReferences[i].setData({
                        'name': NewAccount.newUser.floors[i].name,
                        'basePrice': NewAccount.newUser.floors[i].basePrice,
                        'finalPrice': NewAccount.newUser.floors[i].finalPrice,
                        'selectedDates':
                            NewAccount.newUser.floors[i].selectedDates,
                        'isSelected': NewAccount.newUser.floors[i].isSelected,
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
