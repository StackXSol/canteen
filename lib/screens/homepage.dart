import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        SizedBox(height: getheight(context, 50)),
        Icon(Icons.shopping_cart),
        SizedBox(
          height: getheight(context, 19),
        )
      ],
    )));
  }
}
