import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:guesthouseapp/widgets/chip_payment_mode.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddNewPayment extends StatefulWidget {
  final User currentUser;
  AddNewPayment(this.currentUser);
  @override
  _AddNewPaymentState createState() => _AddNewPaymentState();
}

class _AddNewPaymentState extends State<AddNewPayment> {
  String _payerName = '';
  bool _cashSelected = false;
  bool _chequeSelected = false;
  int amount = 0;
  bool _showSpinner = false;
  DateTime paidOn;
  String _selectedDate = 'Tap to select date';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
    );
    if (d != null) {
      setState(() {
        _selectedDate = DateFormat.yMMMMd("en_US").format(d);
        paidOn = d;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      //TODO Uplifting state
      inAsyncCall: _showSpinner,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextField(
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            hintText: 'Amount',
                            prefixIcon: Icon(
                              Icons.attach_money,
                              size: 20.0,
                            )),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          try {
                            {
                              setState(() {
                                amount = int.parse(value);
                              });
                            }
                          } catch (e) {
                            setState(() {
                              amount = 0;
                            });
                          }
                        }),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 10),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: 'Paid By',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _payerName = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 1.0, color: Theme.of(context).accentColor),
                    left: BorderSide(
                        width: 1.0, color: Theme.of(context).accentColor),
                    right: BorderSide(
                        width: 1.0, color: Theme.of(context).accentColor),
                    bottom: BorderSide(
                        width: 1.0, color: Theme.of(context).accentColor),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        _selectedDate,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).accentColor,
                      ),
                      tooltip: 'Tap to open date picker',
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PaymentModeChip(_cashSelected, 'Cash', (bool value) {
                  setState(() {
                    _cashSelected = true;
                    _chequeSelected = false;
                  });
                }),
                PaymentModeChip(_chequeSelected, 'Cheque', (bool value) {
                  setState(() {
                    _cashSelected = false;
                    _chequeSelected = true;
                  });
                }),
              ],
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                elevation: 4.0,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  setState(() {
                    _showSpinner = true;
                  });
                  Firestore.instance
                      .collection('users')
                      .document(widget.currentUser.fromDate.toString())
                      .collection('payments')
                      .document(paidOn.toString())
                      .setData({
                    'amount': amount,
                    'payerName': _payerName,
                    'paymentMode': (_chequeSelected) ? 'Cheque' : 'Cash',
                    'paidOn': paidOn
                  });
                  setState(() {
                    _showSpinner = false;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Add Payment',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
