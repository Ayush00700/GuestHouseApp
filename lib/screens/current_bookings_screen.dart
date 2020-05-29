import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/models/floor.dart';
import 'package:guesthouseapp/screens/new_account.dart';
import 'package:guesthouseapp/models/users.dart';
import 'package:guesthouseapp/widgets/user_card.dart';

class CurrentBookingScreen extends StatelessWidget {
  final Admin _currentAdmin;
  final _firestore = Firestore.instance;
  final List<User> userList = [];
  List<UserCard> userCard = [];

  CurrentBookingScreen(this._currentAdmin);

  void getDetails(List<DocumentSnapshot> users) {
    for (DocumentSnapshot user in users) {
      User addUser = User();
      addUser.name = user.data['name'];
      addUser.addressL1 = user.data['addressl1'];
      addUser.addressL2 = user.data['addressl2'];
      addUser.mobileNo = user.data['mobileNo'];
      addUser.mobileNoName = user.data['mobileNoName'];
      addUser.mobileNoAlt = user.data['mobileNoAlt'];
      addUser.mobileNoAltName = user.data['mobileNoAltName'];
      addUser.fromDate = user.data['fromDate'].toDate();
      addUser.toDate = user.data['toDate'].toDate();
      addUser.remarks = user.data['remarks'];
      addUser.price = user.data['price'];
      addUser.rebate = user.data['rebate'];
      addUser.finalPrice = user.data['finalPrice'];
      addUser.addedBy = Admin(name: user.data['createdBy']);
      getFloors(addUser, user);
      userList.add(addUser);
      userCard.add(UserCard(addUser));
    }
  }

  void getFloors(addUser, user) async {
    for (int j = 0; j < 3; j++) {
      DocumentReference floora = user.data['floors'][j];
      DocumentSnapshot floor = await floora.get();
      Floor newFloor = Floor(
          name: floor.data['name'],
          basePrice: floor.data['basePrice'],
          finalPrice: floor.data['finalPrice'],
          isSelected: floor.data['isSelected'],
          selectedDates: new List<bool>(floor.data['selectedDates'].length));
      List selectedDates = floor.data['selectedDates'];
      int c = 0;
      for (var selectDates in selectedDates) {
        newFloor.selectedDates[c++] = selectDates;
      }
      addUser.floors[j] = newFloor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Bookings'), actions: <Widget>[
        IconButton(
          iconSize: 30.0,
          tooltip: 'Add New Booking',
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewAccount(_currentAdmin),
            ),
          ),
        ),
      ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          }
          final users = snapshot.data.documents;
          getDetails(users);
          // userList.add(addUser);
          return ListView(children: userCard);
        },
      ),
    );
  }
}
