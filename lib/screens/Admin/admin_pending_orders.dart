import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../main.dart';
import '../../widgets.dart';
import 'OrdersToday/todayOrderDetails.dart';

class AdminPendingOrders extends StatefulWidget {
  @override
  State<AdminPendingOrders> createState() => _AdminPendingOrdersState();
}

class _AdminPendingOrdersState extends State<AdminPendingOrders> {
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
                  Text("Pending Orders",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textSize.getadaptiveTextSize(context, 18))),
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
                          .collection("Canteens")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("Revenue")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        List<_PendingItem> _orders = [];
                        if (snapshot.hasData) {
                          var odocs = snapshot.data.docs;
                          for (var i in odocs.reversed) {
                            if (!i.data()["Status"]) {
                              _orders.add(_PendingItem(
                                  total_price: double.parse(
                                      i.data()["Total_Price"].toString()),
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
                                        fontSize: textSize.getadaptiveTextSize(
                                            context, 24)),
                                  ),
                                  SizedBox(
                                    height: getheight(context, 10),
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

  int oid;
  double total_price;
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
                    builder: (context) => TodayOrderDetails(
                        oid: oid, items: items, datetime: datetime)));
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
                    size: getheight(context, 90),
                  ),
                  SizedBox(
                    width: getwidth(context, 12),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OID: " + oid.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 17)),
                        ),
                        SizedBox(height: getheight(context, 10)),
                        Text(
                            // "Rs. $price",
                            DateFormat.jm().format(datetime),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 15),
                                color: orange_color))
                      ]),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: getheight(context, 25)),
                    child: Text("$total_price/-",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: textSize.getadaptiveTextSize(context, 15),
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
