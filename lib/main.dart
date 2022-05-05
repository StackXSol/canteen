import 'package:canteen/screens/cart.dart';
import 'package:canteen/screens/homepage.dart';
import 'package:canteen/screens/loading.dart';
import 'package:canteen/screens/order_details.dart';
import 'package:canteen/screens/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderDetails(),
      title: 'Canteen',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 212, 212, 212),
        fontFamily: "Gilroy",
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      // routes: {
      //   '/homepage': (context) => const HomePage(),
      //   '/loadingscreen': (context) => const LoadingPage(),
      // },
      // initialRoute: '/loadingscreen',
    );
  }
}
