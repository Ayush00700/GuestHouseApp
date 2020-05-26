import 'package:flutter/material.dart';
import 'package:guesthouseapp/screens/new_account.dart';
import 'package:guesthouseapp/widgets/floor_builder.dart';
import 'package:provider/provider.dart';
import 'package:guesthouseapp/models/floor_data.dart';
import 'package:guesthouseapp/models/data.dart';

class RoomSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FloorData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Rooms'),
          leading: Icon(Icons.rv_hookup),
        ),
        body: Consumer<FloorData>(builder: (context, floorData, child) {
          return Column(
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
                                int a = int.parse(value);
                                print(a);
                                floorData.setRebate(value);
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(
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
                          if (floorData.rebate != '')
                            Text('₹ ' + floorData.rebate)
                          else
                            Text('₹ 0')
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
          );
        }),
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
                onTap: () {
                  FloorData().buildfloors();
                  Data().users.add(NewAccount.newUser);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
