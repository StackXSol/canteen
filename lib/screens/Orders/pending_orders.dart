import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';
import 'package:canteen/screens/cart.dart';
import 'package:canteen/screens/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PendingOrders extends StatefulWidget {
  // PendingOrders({required this.food_items});
  // List<Widget> food_items;

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  void initState() {
    super.initState();
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
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(BlocProvider.of<CanteenCubit>(context)
                              .state
                              .currentuser
                              .uid)
                          .collection("Orders")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        List<_PendingItem> _orders = [];
                        if (snapshot.hasData) {
                          var odocs = snapshot.data.docs;
                          for (var i in odocs.reversed) {
                            if (!i.data()["Status"]) {
                              _orders.add(_PendingItem(
                                  total_price: i.data()["Total_Price"],
                                  items: i.data()["Items"],
                                  datetime:
                                      DateTime.parse(i.data()["DateTime"]),
                                  oid: i.data()["OID"]));
                            }
                          }
                        }
                        return Column(
                          children: _orders.length != 0
                              ? _orders
                              : [
                                  SizedBox(
                                    height: getheight(context, 230),
                                  ),
                                  Text(
                                    "No orders Yet!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Hit the orange button down\nbelow to Create an order",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: getheight(context, 235),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    alignment: Alignment.center,
                                    height: getheight(context, 70),
                                    width: getwidth(context, 314),
                                    decoration: BoxDecoration(
                                        color: orange_color,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      "Start odering",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xfff6f6f9)),
                                    ),
                                  ),
                                ],
                        );
                      })),
            ),
            SizedBox(
              height: getheight(context, 10),
            )
          ],
        )));
  }
}

class _PendingItem extends StatelessWidget {
  _PendingItem(
      {required this.total_price,
      required this.oid,
      required this.items,
      required this.datetime});

  int total_price, oid;
  Map items;
  DateTime datetime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetails(
                          oid: oid,
                          paystatus: false,
                          items: items,
                          datetime: datetime,
                        )));
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
                  QrImage(
                    data: oid.toString(),
                    size: 90,
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
                            DateFormat.jm().format(datetime),
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
