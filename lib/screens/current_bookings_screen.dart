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
  CurrentBookingScreen(this._currentAdmin);

  List<bool> selectedDatesofFloors(List dates) {
    List<bool> selectedDates = List();
    for (var date in dates) {
      if (date != null) selectedDates.add(date);
    }
    return selectedDates;
  }

  void getFloors(User addUser, List<DocumentSnapshot> floors, String userID) {
    for (DocumentSnapshot floor in floors) {
      if (floor.documentID == userID + '1st Floor') {
        Floor newFloor = Floor(
          name: floor.data['name'],
          basePrice: floor.data['basePrice'],
          finalPrice: floor.data['finalPrice'],
          isSelected: floor.data['isSelected'],
          selectedDates: selectedDatesofFloors(floor.data['selectedDates']),
        );
        addUser.floors[0] = newFloor;
      }
      if (floor.documentID == userID + '2nd Floor') {
        Floor newFloor = Floor(
          name: floor.data['name'],
          basePrice: floor.data['basePrice'],
          finalPrice: floor.data['finalPrice'],
          isSelected: floor.data['isSelected'],
          selectedDates: selectedDatesofFloors(floor.data['selectedDates']),
        );
        addUser.floors[1] = newFloor;
      }
      if (floor.documentID == userID + '4th Floor') {
        Floor newFloor = Floor(
          name: floor.data['name'],
          basePrice: floor.data['basePrice'],
          finalPrice: floor.data['finalPrice'],
          isSelected: floor.data['isSelected'],
          selectedDates: selectedDatesofFloors(floor.data['selectedDates']),
        );
        addUser.floors[2] = newFloor;
      }
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
          List<UserCard> userCard = [];
          List<String> userId = [];
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          }
          final users = snapshot.data.documents;
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
            userList.add(addUser);
            userId.add(user.documentID);
          }
          return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('floors').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ));
                }
                final floors = snapshot.data.documents;
                for (int index = 0; index < userId.length; index++) {
                  getFloors(userList[index], floors, userId[index]);
                  userCard.add(UserCard(userList[index]));
                }
                return ListView(children: userCard);
              });
          // getFloors(addUser, user);
          // userList.add(addUser);
          // userCard.add(UserCard(addUser));
          // userList.add(addUser);
        },
      ),
    );
  }
}
