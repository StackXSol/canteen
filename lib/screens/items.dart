import 'package:canteen/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Items extends StatefulWidget {
  Items({required this.food_type});
  String food_type;

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
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
                child: Column(
                  children: [
                    _Item(),
                    _Item(),
                    _Item(),
                    _Item(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getheight(context, 10),
            )
          ],
        )));
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getheight(context, 102),
          width: getwidth(context, 325),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.001),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getheight(context, 10)),
            child: Row(
              children: [
                Container(
                  height: getheight(context, 65),
                  width: getheight(context, 65),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.2))),
                  child: Image(image: AssetImage('images/food.png')),
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Veggie tomato mix",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Text("#1999",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: orange_color))
                    ]),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: getheight(context, 30)),
                  height: getheight(context, 23),
                  width: getheight(context, 55),
                  decoration: BoxDecoration(
                      color: orange_color,
                      borderRadius: BorderRadius.circular(30)),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: getheight(context, 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getheight(context, 14),
        )
      ],
    );
  }
}
