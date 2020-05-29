import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/admins.dart';
import 'package:guesthouseapp/screens/dashboard.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'on_press_delete.dart';

class AdminBuilder extends StatefulWidget {
  @override
  _AdminBuilderState createState() => _AdminBuilderState();
}

class _AdminBuilderState extends State<AdminBuilder> {
  bool _showSpinner = false;
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('admins').snapshots(),
          builder: (context, snapshot) {
            List<Admin> admins = [];
            List<String> adminId = [];
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            for (var admin in snapshot.data.documents) {
              admins.add(Admin(name: admin.data['name']));
              adminId.add(admin.documentID);
            }
            return ListView.builder(
              itemCount: admins.length,
              // itemCount: Provider.of<Data>(context).admins.length,
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  color: Theme.of(context).primaryColor,
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
                      //TODO Make pushUntilRemoved
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DashBoardScreen(admins[index]);
                      }));
                    },
                    onLongPress: () =>
                        DeleteFunction('Admin', (String id) async {
                      await _firestore
                          .collection('admins')
                          .document(id)
                          .delete();
                    }, (bool spin) {
                      setState(() {
                        _showSpinner = spin;
                      });
                    }).showDialogBox(
                      context,
                      adminId[index],
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
