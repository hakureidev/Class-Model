import 'package:modul/1/second_day/models/user.dart';

abstract class DataProvider {
  Future <List<User>> getData();
   
}
