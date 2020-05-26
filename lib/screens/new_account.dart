import 'package:flutter/material.dart';
import 'package:guesthouseapp/screens/rooms_select.dart';
import 'package:guesthouseapp/widgets/admin_list.dart';
import 'package:guesthouseapp/widgets/mobile_no.dart';
import 'package:intl/intl.dart';
import 'package:guesthouseapp/models/users.dart';

class NewAccount extends StatefulWidget {
  static Duration dateDifference;
  static User newUser = new User();
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  ScrollController _scrollController;
  String _selectedFromDate = 'Tap to select date';
  String _selectedToDate = 'Tap to select date ';
  final globalKey = GlobalKey<ScaffoldState>();
  Future<void> _selectDate(BuildContext context, String dated) async {
    final DateTime d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
    );
    if (d != null) {
      //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        if (dated == 'from') {
          _selectedFromDate = DateFormat.yMMMMd("en_US").format(d);
          NewAccount.newUser.fromDate = d;
        } else {
          _selectedToDate = DateFormat.yMMMMd("en_US").format(d);
          NewAccount.newUser.toDate = d;
        }
        if (NewAccount.newUser.fromDate != null &&
            NewAccount.newUser.toDate != null) {
          NewAccount.dateDifference = d.difference(NewAccount.newUser.fromDate);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    NewAccount.newUser.addedBy = AdminBuilder.currentAdmin;
    _scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('Create new Account')),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(controller: _scrollController, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                //Customer Details
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Customer Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              TextField(
                //Name
                decoration: InputDecoration(
                    hintText: 'Name', prefixIcon: Icon(Icons.account_circle)),
                onChanged: (value) {
                  setState(() {
                    NewAccount.newUser.name = value;
                    NewAccount.newUser.mobileNoName = value;
                    NewAccount.newUser.mobileNoAltName = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              TextField(
                //Address Line1
                decoration: InputDecoration(
                    hintText: 'Address Line 1', prefixIcon: Icon(Icons.room)),
                onChanged: (value) {
                  setState(() {
                    NewAccount.newUser.addressL1 = value;
                  });
                },
              ),
              TextField(
                //Address Line2
                decoration: InputDecoration(
                    hintText: 'Address Line 2', prefixIcon: Icon(Icons.room)),
                onChanged: (value) {
                  setState(() {
                    NewAccount.newUser.addressL2 = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              MobileNoRow('Mobile No'),
              SizedBox(height: 5.0),
              MobileNoRow('Alternate Mobile No'),
              Divider(
                height: 50,
                thickness: 2,
                indent: 100,
                endIndent: 100,
                color: Colors.black12,
              ),
              Text(
                //Date
                'Date',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                  //fromDate
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 5.0),
                    Text(
                      'FROM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            left: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            right: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            bottom: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                _selectedFromDate,
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                _selectDate(context, 'from');
                                print(_selectedFromDate);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).accentColor,
                              ),
                              tooltip: 'Tap to open date picker',
                              onPressed: () {
                                _selectDate(context, 'from');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 5.0),
              Row(
                  //toDate
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 5.0),
                    Text(
                      'TO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            left: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            right: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            bottom: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                _selectedToDate,
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                _selectDate(context, 'to');
                                print(_selectedToDate);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).accentColor,
                              ),
                              tooltip: 'Tap to open date picker',
                              onPressed: () {
                                _selectDate(context, 'to');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10.0),
              if (NewAccount.dateDifference != null)
                Text(
                  //Date Difference
                  '${NewAccount.dateDifference.inDays + 1} DAYS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              Divider(
                height: 30,
                thickness: 2,
                indent: 100,
                endIndent: 100,
                color: Colors.black12,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).accentColor)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                      minLines: 5,
                      maxLines: 100,
                      decoration:
                          InputDecoration(hintText: 'Remarks(Optional)'),
                      onChanged: (value) {
                        NewAccount.newUser.remarks = value;
                        // _scrollController
                        // .jumpTo(_scrollController.position.maxScrollExtent);
                      }),
                ),
              ),
              SizedBox(
                height: 300.0,
              )
            ],
          ),
        ]),
      ),
      bottomSheet: GestureDetector(
        child: Container(
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
          child: Center(
            child: Text(
              'NEXT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        onTap: () {
          if (NewAccount.dateDifference != null &&
              NewAccount.dateDifference.inDays >= 0)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RoomSelection()));
          else
            globalKey.currentState.showSnackBar(SnackBar(
                content: Container(
                    height: 80.0,
                    child: Text(
                      'Please Select Days to Proceed',
                      textAlign: TextAlign.center,
                    ))));
        },
      ),
    );
  }
}
