import 'dart:io';

import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../main.dart';

class QROrderDetails extends StatefulWidget {
  QROrderDetails(
      {required this.oid,
      required this.paystatus,
      required this.items,
      required this.uid,
      required this.datetime});
  bool paystatus;
  int oid;
  Map items;
  String uid;
  DateTime datetime;

  @override
  State<QROrderDetails> createState() => _QROrderDetailsState();
}

class _QROrderDetailsState extends State<QROrderDetails> {
  @override
  void initState() {
    get_items();
    super.initState();
  }

  List<_Items> _order_items = [];

  void get_items() {
    widget.items.forEach((k, v) => _order_items.add(_Items(
          name: k,
          oid: widget.oid,
          price: v["Price"],
          uid: widget.uid,
          quantity: v["Quantity"],
          image: v["Image"],
          status: v["status"],
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
                  left: getwidth(context, 50), right: getwidth(context, 129)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  Text(
                    "Order details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.uid)
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
                                    height: getheight(context, 194),
                                    width: getwidth(context, 194),
                                    decoration: BoxDecoration(
                                        color: Color(0xff1A9F0B),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getheight(context, 20),
                                  ),
                                  Text(
                                    "Scanned",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  )
                                ],
                              );
                            } else {
                              return Container(
                                height: getheight(context, 274),
                                width: getwidth(context, 272),
                                child: QrImage(data: widget.oid.toString()),
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
                            fontSize: 18,
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
                            fontSize: 18,
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
                  // GestureDetector(
                  //   onTap: () async {
                  //     FirebaseFirestore.instance
                  //         .collection("Canteens")
                  //         .doc(FirebaseAuth.instance.currentUser!.uid)
                  //         .collection("Revenue")
                  //         .doc(widget.oid.toString())
                  //         .set({"Status": true}, SetOptions(merge: true));
                  //     var key = await FirebaseFirestore.instance
                  //         .collection("Users")
                  //         .doc(widget.uid)
                  //         .collection("Orders")
                  //         .where("OID",
                  //             isEqualTo: int.parse(widget.oid.toString()))
                  //         .get();
                  //     FirebaseFirestore.instance
                  //         .collection("Users")
                  //         .doc(widget.uid)
                  //         .collection("Orders")
                  //         .doc(key.docs.first.id)
                  //         .set({"Status": true}, SetOptions(merge: true));
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     alignment: Alignment.center,
                  //     margin: EdgeInsets.symmetric(horizontal: 80),
                  //     decoration: BoxDecoration(
                  //         color: Colors.green,
                  //         borderRadius: BorderRadius.circular(30)),
                  //     child: Center(
                  //       child: Text(
                  //         "Complete Order",
                  //         style: TextStyle(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w800,
                  //             color: Color(0xfff6f6f9)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 10),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getwidth(
                  context,
                  34,
                ),
              ),
              child: const Text(
                "Items Ordered",
                style: TextStyle(
                    fontSize: 17,
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
      required this.status,
      required this.uid,
      required this.price,
      required this.oid,
      required this.quantity,
      required this.image});
  String name, image, uid;
  int price, quantity, oid;
  bool status;

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
                      radius: 35,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                    )),
                SizedBox(
                  width: 20,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Text("₹$price - ${quantity.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: orange_color))
                    ]),
                Spacer(),
                StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(uid)
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
                          onChanged: (val) async {
                            if (st != true) {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              getwidth(context, 10)),
                                          // height: getheight(context, 180),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Alert!",
                                                style: TextStyle(
                                                    color: orange_color,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 22)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 16),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Are you sure you want confirm the item in the order?",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 18)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 22),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  FirebaseFirestore.instance
                                                      .collection("Canteens")
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection("Revenue")
                                                      .doc(oid.toString())
                                                      .set({
                                                    "Items": {
                                                      name: {"status": true}
                                                    }
                                                  }, SetOptions(merge: true));
                                                  var key = await FirebaseFirestore
                                                      .instance
                                                      .collection("Users")
                                                      .doc(uid)
                                                      .collection("Orders")
                                                      .where("OID",
                                                          isEqualTo: int.parse(
                                                              oid.toString()))
                                                      .get();
                                                  FirebaseFirestore.instance
                                                      .collection("Users")
                                                      .doc(uid)
                                                      .collection("Orders")
                                                      .doc(key.docs.first.id)
                                                      .set({
                                                    "Items": {
                                                      name: {"status": true}
                                                    }
                                                  }, SetOptions(merge: true));

                                                  //checking completion of order

                                                  dynamic cmp_key =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Canteens")
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection("Revenue")
                                                          .doc(oid.toString())
                                                          .get();

                                                  Map _items =
                                                      cmp_key.data()["Items"];

                                                  bool _pending = false;

                                                  try {
                                                    _items.forEach((k, v) {
                                                      if (!v['status']) {
                                                        _pending = true;
                                                        throw Exception();
                                                      }
                                                    });
                                                  } catch (e) {}

                                                  if (!_pending) {
                                                    FirebaseFirestore.instance
                                                        .collection("Canteens")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .collection("Revenue")
                                                        .doc(oid.toString())
                                                        .set({
                                                      "Status": true
                                                    }, SetOptions(merge: true));
                                                    var key =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(uid)
                                                            .collection(
                                                                "Orders")
                                                            .where("OID",
                                                                isEqualTo: int
                                                                    .parse(oid
                                                                        .toString()))
                                                            .get();
                                                    FirebaseFirestore.instance
                                                        .collection("Users")
                                                        .doc(uid)
                                                        .collection("Orders")
                                                        .doc(key.docs.first.id)
                                                        .set({
                                                      "Status": true
                                                    }, SetOptions(merge: true));
                                                  }
                                                },
                                                child: Container(
                                                  height:
                                                      getheight(context, 40),
                                                  width: getwidth(context, 130),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: orange_color),
                                                  child: Center(
                                                    child: Text(
                                                      "confirm",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: textSize
                                                              .getadaptiveTextSize(
                                                                  context, 17)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Status can't be changed!");
                            }
                          });
                    }),
                // Text(
                //   quantity.toString(),
                //   style: TextStyle(
                //       color: orange_color,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w600),
                // ),
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
