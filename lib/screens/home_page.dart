import 'package:capacitacionflutter3/blocs/cart_bloc.dart';
import 'package:capacitacionflutter3/models/cart_model.dart';
import 'package:capacitacionflutter3/models/item.dart';
import 'package:capacitacionflutter3/screens/cart_detail.dart';
import 'package:capacitacionflutter3/screens/feed_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CartModel _cartModel;
  CartBloc _cartBloc;

  List<Item> _items = [
    Item(id: 1, name: "Papa", price: 1000),
    Item(id: 2, name: "Yuca", price: 500),
    Item(id: 3, name: "Platano", price: 700),
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _cartModel = Provider.of<CartModel>(context);
    _cartBloc = Provider.of<CartBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blumer Store"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FeedPage(),
                ));
              }),
          Stack(
            children: [
              IconButton(
                  icon: Icon(Icons.shopping_cart_sharp),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartDetail()));
                  }),
              StreamBuilder<int>(
                stream: _cartBloc.totalProducts,
                builder: (context, snapshot) {
                  return Positioned(
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                      child: Text(snapshot.data.toString()),
                    ),
                  );
                }
              )
            ],
          )
        ],
      ),
      body: StreamBuilder<List<Item>>(
          stream: _cartBloc.getItems,
          builder: (context, snapshot) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final exists = _cartBloc.exists(item);
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.price.toString()),
                    trailing: IconButton(
                      icon: !exists ? Icon(Icons.add) : Icon(Icons.delete),
                      onPressed: () {
                        if (!exists) {
                          _cartBloc.addProduct(item);
                        } else {
                          _cartBloc.remove(item);
                        }
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: _items.length);
          }),
    );
  }

  Widget withChangeNotifier() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final item = _items[index];
          return ChangeNotifierProvider<Item>.value(
            value: item,
            builder: (context, child) {
              return Consumer<Item>(
                builder: (context, value, child) {
                  return ListTile(
                    title: Text(value.name),
                    trailing: !value.selected
                        ? TextButton(
                            child: Text("ADD"),
                            onPressed: () {
                              // _cartModel.add(_items[index]);
                              value.selectedItem();
                            },
                          )
                        : TextButton.icon(
                            onPressed: () {
                              // _cartModel.remove(_items[index]);
                              value.selectedItem();
                            },
                            icon: Icon(Icons.check),
                            label: Text("")),
                  );
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: _items.length);
  }
}
