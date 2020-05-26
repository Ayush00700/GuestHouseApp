// import 'package:flutter/material.dart';
import 'package:guesthouseapp/models/users.dart';
import 'admins.dart';

class Data {
  List<User> users;
  static List<Admin> admins = [];
  static void basicUsers() {
    admins.add(Admin(name: 'Suresh'));
    admins.add(Admin(name: 'Shakuntala'));
    admins.add(Admin(name: 'Vinay'));
    admins.add(Admin(name: 'Jyoti'));
    admins.add(Admin(name: 'Archie'));
  }
}
