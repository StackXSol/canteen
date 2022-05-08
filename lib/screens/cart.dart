import 'package:canteen/widgets.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: getheight(context, 50)),
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
                  Text("Cart",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Spacer(),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: orange_color,
                    size: getheight(context, 24),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, getheight(context, 40)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Item(),
                    Item(),
                    Item(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                height: getheight(context, 70),
                width: getwidth(context, 314),
                decoration: BoxDecoration(
                    color: orange_color,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Complete Order",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xfff6f6f9)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
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
            padding: EdgeInsets.symmetric(horizontal: getwidth(context, 10)),
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
                  height: getheight(context, 30),
                  width: getheight(context, 65),
                  decoration: BoxDecoration(
                      color: orange_color,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: getheight(context, 14),
                        ),
                      ),
                      Text(
                        "1",
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: getheight(context, 14),
                        ),
                      )
                    ],
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
