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
        Padding(
          padding: EdgeInsets.only(right: getwidth(context, 40)),
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey,
                size: getheight(context, 24),
              )),
        ),
        SizedBox(
          height: getheight(context, 19),
        ),
        Text("Hello Diana",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900))
      ],
    )));
  }
}
