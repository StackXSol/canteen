import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../widgets.dart';

class TodayOrderDetails extends StatefulWidget {
  TodayOrderDetails(
      {required this.oid, required this.items, required this.datetime});

  int oid;
  Map items;

  DateTime datetime;

  @override
  State<TodayOrderDetails> createState() => _TodayOrderDetailsState();
}

class _TodayOrderDetailsState extends State<TodayOrderDetails> {
  @override
  void initState() {
    get_items();
    super.initState();
  }

  List<_Items> _order_items = [];

  void get_items() {
    widget.items.forEach((k, v) => _order_items.add(_Items(
          name: k,
          price: double.parse(v["Price"].toString()),
          quantity: v["Quantity"],
          image: v["Image"],
        )));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getheight(context, 60),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getwidth(context, 30), right: getwidth(context, 129)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.keyboard_arrow_left),
                      )),
                  SizedBox(
                    width: getwidth(context, 75),
                  ),
                  Text(
                    "Order details",
                    style: TextStyle(
                        fontSize: textSize.getadaptiveTextSize(context, 18),
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 36),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "OID: " + widget.oid.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize.getadaptiveTextSize(context, 30)),
                  ),
                  SizedBox(height: getheight(context, 28)),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: textSize.getadaptiveTextSize(context, 18),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                        children: [
                          TextSpan(
                              text: DateFormat.yMMMd().format(widget.datetime),
                              style: TextStyle(fontWeight: FontWeight.w300))
                        ]),
                  ),
                  SizedBox(
                    height: getheight(context, 15),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: textSize.getadaptiveTextSize(context, 18),
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        children: [
                          TextSpan(
                              text: DateFormat.jm().format(widget.datetime),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black))
                        ]),
                  ),
                  SizedBox(
                    height: getheight(context, 25),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 38),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getwidth(
                  context,
                  34,
                ),
              ),
              child: Text(
                "Items Ordered",
                style: TextStyle(
                    fontSize: textSize.getadaptiveTextSize(context, 17),
                    fontWeight: FontWeight.w400,
                    color: Color(0xffF94A0D)),
              ),
            ),
            SizedBox(
              height: getheight(context, 26),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: getwidth(context, 34)),
                child: SingleChildScrollView(
                  child: Column(children: _order_items),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Items extends StatelessWidget {
  _Items(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.image});
  String name, image;
  int quantity;
  double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: getwidth(context, 315),
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
            padding: EdgeInsets.symmetric(
                horizontal: getheight(context, 17),
                vertical: getheight(context, 12)),
            child: Row(
              children: [
                Container(
                    height: getheight(context, 65),
                    width: getheight(context, 65),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.2))),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: getheight(context, 35),
                      backgroundColor: Colors.grey.withOpacity(0.1),
                    )),
                SizedBox(
                  width: getwidth(context, 20),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: getwidth(context, 160),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 16)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("???$price",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 15),
                              color: orange_color))
                    ]),
                Spacer(),
                Text(
                  quantity.toString(),
                  style: TextStyle(
                      color: orange_color,
                      fontSize: textSize.getadaptiveTextSize(context, 16),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 6,
                )
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
