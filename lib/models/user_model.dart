import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String user = "username";

  void changeName(String newName) {
    user = newName;
    notifyListeners();
  }
}
