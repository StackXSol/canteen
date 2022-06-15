import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../cubit/canteen_cubit.dart';
import '../main.dart';
import '../widgets.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails(
      {required this.oid,
      required this.paystatus,
      required this.items,
      required this.datetime});
  bool paystatus;
  int oid;
  Map items;
  DateTime datetime;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    get_items();
    super.initState();
  }

  List<_Items> _order_items = [];

  void get_items() {
    widget.items.forEach((k, v) => _order_items.add(_Items(
          name: k,
          price: v["Price"],
          quantity: v["Quantity"],
          image: v["Image"],
          oid: widget.oid,
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
                  left: getwidth(context, 40), right: getwidth(context, 129)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
              height: getheight(context, 30),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(BlocProvider.of<CanteenCubit>(context)
                              .state
                              .currentuser
                              .uid)
                          .collection("Orders")
                          .where("OID", isEqualTo: widget.oid)
                          .snapshots(),
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          for (var i in snapshot.data.docs) {
                            if (i.data()["Status"]) {
                              return Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: getheight(context, 174),
                                    width: getwidth(context, 172),
                                    decoration: BoxDecoration(
                                        color: Color(0xff1A9F0B),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      size: getheight(context, 100),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getheight(context, 20),
                                  ),
                                  Text(
                                    "Scanned",
                                    style: TextStyle(
                                        fontSize: textSize.getadaptiveTextSize(
                                            context, 22),
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  )
                                ],
                              );
                            } else {
                              return Container(
                                height: getheight(context, 194),
                                width: getwidth(context, 194),
                                child: QrImage(
                                    data: [
                                  widget.oid,
                                  FirebaseAuth.instance.currentUser!.uid
                                ].toString()),
                              );
                            }
                          }
                        }
                        return Column();
                      })),
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 28),
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
      required this.oid,
      required this.image});
  String name, image;
  int price, quantity, oid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getheight(context, 102),
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
            padding: EdgeInsets.symmetric(horizontal: getheight(context, 17)),
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
                        width: getwidth(context, 150),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 16)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("₹$price - ${quantity.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 15),
                              color: orange_color))
                    ]),
                Spacer(),
                StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("Orders")
                        .where("OID", isEqualTo: oid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      bool st = false;
                      if (snapshot.hasData) {
                        for (var element in snapshot.data.docs) {
                          st = element.data()["Items"][name]["status"];
                        }
                      }
                      return Checkbox(
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                          value: st,
                          onChanged: (val) async {});
                    }),
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
