

import 'package:flutter/foundation.dart';

class Item extends ChangeNotifier {
  int id;
  String name;
  double price;
  bool selected = false;

  Item({this.id, this.name, this.price, this.selected = false});

  void selectedItem() {
    selected = !selected;
    notifyListeners();
  }
}
