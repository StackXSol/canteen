import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/screens/Admin/OrdersToday/ordersToday.dart';
import 'package:canteen/screens/Admin/add_food.dart';
import 'package:canteen/screens/Admin/my_menu.dart';
import 'package:canteen/screens/Admin/MonthlyOrders/orders_this_month.dart';
import 'package:canteen/screens/Admin/qrScanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: getheight(context, 65)),
            Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getwidth(context, 22)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "College " +
                                BlocProvider.of<CanteenCubit>(context)
                                    .state
                                    .currentCanteenUser
                                    .getter()[4],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w900)),
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          BlocProvider.of<CanteenCubit>(context)
                              .state
                              .currentCanteenUser
                              .getter()[0],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: getheight(context, 45),
            ),
            Container(
              width: getwidth(context, 300),
              decoration: BoxDecoration(
                  color: Color(0xFFFFDBDB),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's revenue",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection("Canteens")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("Revenue")
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              int total_revenue = 0;

                              if (snapshot.hasData) {
                                for (var i in snapshot.data.docs) {
                                  if ("${DateTime.parse(i.data()["DateTime"]).day} + '/' + ${DateTime.parse(i.data()["DateTime"]).month} + '/' + ${DateTime.parse(i.data()["DateTime"]).year}" ==
                                      "${DateTime.now().day} + '/' + ${DateTime.now().month} + '/' + ${DateTime.now().year}") {
                                    total_revenue += int.parse(
                                        i.data()["Total_Price"].toString());
                                  }
                                }
                              }

                              return Text("\u{20B9} $total_revenue",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold));
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///////////// my menu
                GestureDetector(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMenu()),
                    );
                  }),
                  child: Container(
                    // height: getheight(context, 147),
                    width: getwidth(context, 148),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 45,
                            backgroundImage: NetworkImage(
                                'https://static.thenounproject.com/png/3186085-200.png')),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "My Menu",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  //////////////////add food
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddFood()),
                    );
                  }),
                  child: Container(
                    // height: getheight(context, 147),
                    width: getwidth(context, 148),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/dd/9d/c9/dd9dc9d83423bc037b511d73b29e6b80.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Add Food",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getheight(context, 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrdersOfMonth()),
                    );
                  }),
                  child: Container(
                    // height: getheight(context, 147),
                    width: getwidth(context, 148),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/1356/1356594.png'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Orders this\nMonth",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrdersToday()),
                    );
                  }),
                  child: Container(
                    // height: getheight(context, 147),
                    width: getwidth(context, 148),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/2649/2649223.png'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Orders Today",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getheight(context, 30)),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QrScanner()));
              },
              child: Container(
                height: getheight(context, 58),
                width: getwidth(context, 275),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: orange_color),
                child: Center(
                  child: Text(
                    "Scan QR",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getheight(context, 10),
            )
          ]),
        ));
      },
    );
  }
}
