import 'package:capacitacionflutter3/blocs/cart_bloc.dart';
import 'package:capacitacionflutter3/models/cart_model.dart';
import 'package:capacitacionflutter3/models/feed_model.dart';
import 'package:capacitacionflutter3/models/rx_provider.dart';
import 'package:capacitacionflutter3/models/user_model.dart';
import 'package:capacitacionflutter3/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => FeedModel()),
        Provider<RxProvider>(
          create: (context) => RxProvider(),
          lazy: false,
          dispose: (context, value) {
            value.dispose();
          },
        ),
        Provider<CartBloc>(
          create: (context) => CartBloc(),
          dispose: (context, value) {
            value.dispose();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
