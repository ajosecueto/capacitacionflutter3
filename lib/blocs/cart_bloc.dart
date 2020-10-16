import 'package:capacitacionflutter3/models/item.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  BehaviorSubject<List<Item>> _items = BehaviorSubject<List<Item>>.seeded([]);

  Stream<List<Item>> get getItems => _items.stream;
  List<Item> items = [];

  BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  Stream<int> get totalProducts => _itemCount.stream;

  CartBloc() {
    _items.listen((value) {
      _itemCount.sink.add(value.length);
    });
  }

  void addProduct(Item item) {
    items.add(item);
    _items.sink.add(items);
  }

  void remove(Item item) {
    items.remove(item);
    _items.sink.add(items);
  }

  bool exists(Item item) {
    return items.indexWhere((element) => element.id == item.id) >= 0;
  }

  void dispose() {
    _items.close();
    _itemCount.close();
  }
}
