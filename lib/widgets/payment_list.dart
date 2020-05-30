import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/payment.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:intl/intl.dart';

class PaymentList extends StatelessWidget {
  final _firestore = Firestore.instance;
  final User currentUser;
  PaymentList(this.currentUser);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Payments',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 50.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 2),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .document(currentUser.fromDate.toString())
                .collection('payments')
                .snapshots(),
            builder: (context, snaphot) {
              List<Payment> paymentList = [];
              List<PaymentWidget> paymentWidget = [];
              final paymentsAdded = snaphot.data.documents;
              for (DocumentSnapshot payment in paymentsAdded) {
                Payment paymentItem = Payment(
                    payment.data['amount'],
                    payment.data['payerName'],
                    payment.data['paidOn'].toDate(),
                    payment.data['paymentMode']);
                paymentList.add(paymentItem);
                paymentWidget.add(PaymentWidget(paymentItem));
              }
              return Column(children: paymentWidget);
            })
      ],
    );
  }
}

class PaymentWidget extends StatelessWidget {
  final Payment paymentItem;
  PaymentWidget(this.paymentItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(paymentItem.payerName),
      leading: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          paymentItem.paymentMode,
          style:
              TextStyle(color: Theme.of(context).accentColor, fontSize: 15.0),
        ),
      ),
      subtitle: Text(DateFormat.yMMMMd("en_US").format(paymentItem.paidOn)),
      trailing: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          '₹ ' + paymentItem.amount.toString(),
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0),
        ),
      ),
    );
  }
}
