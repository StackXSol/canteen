import 'package:canteen/main.dart';
import 'package:canteen/screens/cart.dart';
import 'package:canteen/screens/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PendingOrders extends StatefulWidget {
  // PendingOrders({required this.food_items});
  // List<Widget> food_items;

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  List<Widget> _orders = [];

  @override
  void initState() {
    get_orders();
    super.initState();
  }

  void get_orders() async {
    _orders = [];
    var key = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .collection("Orders")
        .get();

    for (var i in key.docs) {
      if (i.data()["Status"]) {
        _orders.add(_PendingItem(
            total_price: i.data()["Total_Price"], oid: i.data()["OID"]));
      }
    }
    setState(() {});
  }

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
                  Text("Orders",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, getheight(context, 30)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: _orders
                    // widget.food_items

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

class _PendingItem extends StatelessWidget {
  _PendingItem({required this.total_price, required this.oid});

  int total_price, oid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OrderDetails(oid: oid, paystatus: false)));
          },
          child: Container(
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
                  CircleAvatar(
                    radius: 35,
                    // backgroundImage: NetworkImage(image),
                    backgroundImage: NetworkImage(
                        "https://www.listchallenges.com/f/items/57fc372f-9ae7-44e7-b35d-68c8d5bd8df0.jpg"),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          oid.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                            // "Rs. $price",
                            "Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: orange_color))
                      ]),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: getheight(context, 25)),
                    child: Text("$total_price/-",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: orange_color)),
                  ),
                ],
              ),
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
