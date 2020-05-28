import 'admins.dart';
import 'floor.dart';

class User {
  String name = '';
  String addressL1 = '';
  String addressL2 = '';
  String mobileNo = '';
  String mobileNoName = '';
  String mobileNoAlt = '';
  String mobileNoAltName = '';
  DateTime fromDate;
  DateTime toDate;
  List<Floor> floors = new List(3);
  String remarks = '';
  String price = '0';
  String rebate = '0';
  String finalPrice = '0';
  Admin addedBy;
}
