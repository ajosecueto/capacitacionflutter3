import 'dart:collection';

import 'package:capacitacionflutter3/models/item.dart';
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {

  double bonus = 1;

  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice =>
      items.fold(0, (previousValue, element) => previousValue + element.price) * bonus;

  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  bool isAdded(Item item) {
    return _items.indexWhere((element) => element.id == item.id) >= 0;
  }

  setBonus(double d){
    bonus = d;
    notifyListeners();
  }
}
