import 'package:canteen/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen',
      theme: ThemeData(
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      routes: {
        '/homepage': (context) => const HomePage(),
      },
      initialRoute: '/navbar',
    );
  }
}
