import 'dart:math';

import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';
import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                      int OID = Random().nextInt(100000000) +
                          Random().nextInt(1000000) +
                          Random().nextInt(10000) +
                          Random().nextInt(100);
                      for (var i in cart_list) {
                        total_price += int.parse(i[2].toString()) *
                            int.parse(i[3].toString());
                        _orders[i[0]] = {
                          "Price": i[2] * i[3],
                          "Quantity": i[3]
                        };
                      }
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("Orders")
                          .doc(DateTime.now().toString())
                          .set({
                        "OID": OID,
                        "DateTime": DateTime.now().toString(),
                        "Total_Price": total_price,
                        "Status": false,
                        "Items": _orders
                      }, SetOptions(merge: true));
                      print(total_price);
                      print(OID);
                      print(_orders);
                      cart_list = [];
                      BlocProvider.of<CanteenCubit>(context)
                          .update_cart(cart_list, context);
                      // BlocProvider.of<CanteenCubit>(context).get_user_data(
                      //     FirebaseAuth.instance.currentUser!.uid);
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
