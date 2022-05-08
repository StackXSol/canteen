import 'package:canteen/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Food_Items extends StatefulWidget {
  Food_Items({required this.food_type, required this.food_items});
  String food_type;
  List<Widget> food_items;

  @override
  State<Food_Items> createState() => _Food_ItemsState();
}

class _Food_ItemsState extends State<Food_Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F8),
        body: Container(
            child: Column(
          children: [
            SizedBox(height: getheight(context, 60)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_arrow_left)),
                  Spacer(),
                  Text(widget.food_type,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                      );
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.grey,
                      size: getheight(context, 24),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, getheight(context, 30)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: widget.food_items),
              ),
            ),
            SizedBox(
              height: getheight(context, 10),
            )
          ],
        )));
  }
}
