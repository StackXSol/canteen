import 'dart:math';

import 'package:canteen/PaymentGateway/payment.dart';
import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';
import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffF5F5F8),
          body: Container(
            child: Column(
              children: [
                SizedBox(height: getheight(context, 50)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.keyboard_arrow_left)),
                    Spacer(),
                    Text("Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Spacer(),
                    CartWid()
                  ]),
                ),
                SizedBox(
                  height: getheight(context, getheight(context, 40)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: BlocProvider.of<CanteenCubit>(context)
                                    .state
                                    .cart_items
                                    .length !=
                                0
                            ? BlocProvider.of<CanteenCubit>(context)
                                .state
                                .cart_items
                            : [
                                SizedBox(
                                  height: getheight(context, 230),
                                ),
                                Text(
                                  "Empty Cart!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Add delicious food to your cart and\nenjoy your meal on order completion!",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      int total_price = 0;
                      DateTime time = DateTime.now();
                      Map _orders = {};
                      List<Widget> dialogitemsList = [];
                      int OID = Random().nextInt(100000000) +
                          Random().nextInt(1000000) +
                          Random().nextInt(10000) +
                          Random().nextInt(100);
                      for (var i in cart_list) {
                        total_price += int.parse(i[2].toString()) *
                            int.parse(i[3].toString());
                        _orders[i[0]] = {
                          "Price": i[2] * i[3],
                          "Quantity": i[3],
                          "Image": i[1]
                        };
                      }
                      for (var i in cart_list) {
                        dialogitemsList.add(
                            _ItemRow(item: i[0].toString(), quantity: i[3]));
                      }

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocBuilder<CanteenCubit, CanteenState>(
                              builder: (context, state) {
                                return AlertDialog(
                                  content: Form(
                                    // key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Details",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text("Items",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("Quantity",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: dialogitemsList,
                                        ),
                                        SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Text(
                                              "Total:",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                                "\u{20B9} ${total_price.toString()}/-",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: () async {
                                            ///// Complete your order
                                            ///
                                            void reg_order() {
                                              print("Registering Order!");
                                              FirebaseFirestore.instance
                                                  .collection("Users")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection("Orders")
                                                  .doc(
                                                      DateTime.now().toString())
                                                  .set({
                                                "OID": OID,
                                                "DateTime":
                                                    DateTime.now().toString(),
                                                "Total_Price": total_price,
                                                "Status": false,
                                                "Items": _orders
                                              }, SetOptions(merge: true));

                                              FirebaseFirestore.instance
                                                  .collection("Canteens")
                                                  .doc(canteenId)
                                                  .collection("Revenue")
                                                  .doc(OID.toString())
                                                  .set({
                                                "OID": OID,
                                                "DateTime":
                                                    DateTime.now().toString(),
                                                "Total_Price": total_price,
                                                "Status": false,
                                                "Items": _orders
                                              }, SetOptions(merge: true));

                                              FirebaseFirestore.instance
                                                  .collection("Canteens")
                                                  .doc(canteenId)
                                                  .set({
                                                "Total_Revenue":
                                                    FieldValue.increment(
                                                        total_price)
                                              }, SetOptions(merge: true));

                                              cart_list = [];
                                              BlocProvider.of<CanteenCubit>(
                                                      context)
                                                  .update_cart(
                                                      cart_list, context);
                                              Navigator.pop(context);
                                            }

                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => py_pg(
                                                          price: total_price,
                                                        ))).then((value) {
                                              print(
                                                  BlocProvider.of<CanteenCubit>(
                                                              context)
                                                          .state
                                                          .paymentstatus
                                                          .toString() +
                                                      "hellogdfdsf");
                                              if (BlocProvider.of<CanteenCubit>(
                                                      context)
                                                  .state
                                                  .paymentstatus) {
                                                reg_order();
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: getheight(context, 50),
                                            width: getwidth(context, 100),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: orange_color),
                                            child: Center(
                                              child: Text(
                                                "Pay Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                    },
                    child: Visibility(
                      visible: BlocProvider.of<CanteenCubit>(context)
                              .state
                              .cart_items
                              .length >
                          0,
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ItemRow extends StatelessWidget {
  _ItemRow({required this.item, required this.quantity});

  String item;
  int quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              item,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          children: [Text(quantity.toString())],
        )
      ],
    );
  }
}
