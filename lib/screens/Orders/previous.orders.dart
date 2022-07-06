import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/canteen_cubit.dart';
import '../../main.dart';
import '../../widgets.dart';
import '../order_details.dart';

class PreviousOrders extends StatefulWidget {
  // PendingOrders({required this.food_items});
  // List<Widget> food_items;

  @override
  State<PreviousOrders> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  List<Widget> _orders = [];

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
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.keyboard_arrow_left),
                      )),
                  SizedBox(
                    width: getwidth(context, 75),
                  ),
                  Text("Orders",
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
                          .collection("Users")
                          .doc(BlocProvider.of<CanteenCubit>(context)
                              .state
                              .currentuser
                              .uid)
                          .collection("Orders")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        List<_PrevItem> _orders = [];
                        if (snapshot.hasData) {
                          var odocs = snapshot.data.docs;
                          for (var i in odocs.reversed) {
                            if (i.data()["Status"]) {
                              _orders.add(_PrevItem(
                                  items: i.data()["Items"],
                                  datetime:
                                      DateTime.parse(i.data()["DateTime"]),
                                  total_price: double.parse(
                                      i.data()["Total_Price"].toString()),
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
                                  Text(
                                    "Surf through main screen\nto Create an order",
                                    style: TextStyle(
                                        fontSize: textSize.getadaptiveTextSize(
                                            context, 16)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: getheight(context, 235),
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

class _PrevItem extends StatelessWidget {
  _PrevItem(
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
                    builder: (context) => OrderDetails(
                          oid: oid,
                          paystatus: true,
                          items: items,
                          datetime: datetime,
                        )));
          },
          child: Container(
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
              padding: EdgeInsets.symmetric(
                  horizontal: getheight(context, 10),
                  vertical: getheight(context, 12)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: getheight(context, 35),
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: getheight(context, 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 18,
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
