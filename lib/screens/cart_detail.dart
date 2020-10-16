import 'package:capacitacionflutter3/blocs/cart_bloc.dart';
import 'package:capacitacionflutter3/models/cart_model.dart';
import 'package:capacitacionflutter3/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartDetail extends StatefulWidget {
  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    final _cartModel = context.watch<CartModel>();
    final _cartBloc = context.watch<CartBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartBloc.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_cartBloc.items[index].name),
                );
              },
            ),
          ),
          Slider(
            onChanged: (value) {
              _cartModel.setBonus(value.toInt().toDouble());
            },
            value: _cartModel.bonus,
            min: 1,
            max: 10,
            divisions: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("El usuario es ${context.watch<UserModel>().user}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total de la cuenta es: ${_cartModel.totalPrice}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
              onPressed: () {
                context.read<UserModel>().changeName("Nuevo nombre");
              },
              child: Text("Cambiar el nombre del usuario"))
        ],
      ),
    );
  }
}
