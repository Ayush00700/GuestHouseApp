import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/screens/dashboard.dart';

class AdminBuilder extends StatefulWidget {
  static Admin currentAdmin;
  @override
  _AdminBuilderState createState() => _AdminBuilderState();
}

class _AdminBuilderState extends State<AdminBuilder> {
  final _firestore = Firestore.instance;
  List<Admin> admins = [];

  void getUser() async {
    await for (var snapshot
        in _firestore.collection('admins').orderBy('createdAt').snapshots()) {
      admins = [];
      for (var message in snapshot.documents) {
        if (message.data['name'] != null)
          setState(() {
            admins.add(Admin(
                name: message.data['name'],
                createdAt: message.data['createdAt'].toDate()));
          });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // Data().basicUsers();
    return ListView.builder(
      itemCount: admins.length,
      // itemCount: Provider.of<Data>(context).admins.length,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          child: ListTile(
            title: Text(
              admins[index].name,
              // Provider.of<Data>(context).admins[index].name,
              style: TextStyle(fontSize: 20.0),
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
            onTap: () {
              AdminBuilder.currentAdmin = admins[index];
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DashBoardScreen(AdminBuilder.currentAdmin);
              }));
            },
            trailing: Icon(
              Icons.navigate_next,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
