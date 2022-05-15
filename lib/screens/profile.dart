import 'package:canteen/main.dart';
import 'package:canteen/screens/Orders/previous.orders.dart';
import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/canteen_cubit.dart';
import 'Authentication/login_signup.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String phone = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffF5F5F8),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getheight(context, 60)),
                Row(
                  children: [
                    SizedBox(
                      width: getwidth(context, 35),
                    ),
                    Text(
                      "My Profile",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: getheight(context, 42),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: getwidth(context, 35),
                      right: getwidth(context, 47)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Personal Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            child: Icon(Icons.close),
                                            backgroundColor: orange_color,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text("Edit Details"),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  validator: (value) {
                                                    if (value
                                                            .toString()
                                                            .length <
                                                        4) {
                                                      return "Enter valid Name!";
                                                    }
                                                  },
                                                  onChanged: ((value) {
                                                    name = value;
                                                  }),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  decoration: InputDecoration(
                                                      hintText: "Enter name",
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5)))),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  validator: (value) {
                                                    if (value
                                                            .toString()
                                                            .length !=
                                                        10) {
                                                      return "Enter valid Number!";
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    phone = value;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  decoration: InputDecoration(
                                                      hintText: "Phone number",
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5)))),
                                            ),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  FirebaseFirestore.instance
                                                      .collection("Users")
                                                      .doc(BlocProvider.of<
                                                                  CanteenCubit>(
                                                              context)
                                                          .state
                                                          .currentuser
                                                          .uid)
                                                      .set({
                                                    "Fullname": name,
                                                    "phone": phone
                                                  }, SetOptions(merge: true));
                                                  BlocProvider.of<CanteenCubit>(
                                                          context)
                                                      .get_user_data(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          context);
                                                  Navigator.pop(context);
                                                  Fluttertoast.showToast(
                                                      msg: "Details Updated!");
                                                }
                                              },
                                              child: Container(
                                                height: getheight(context, 50),
                                                width: getwidth(context, 100),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: orange_color),
                                                child: Center(
                                                  child: Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "edit",
                          style: TextStyle(
                            fontSize: 15,
                            color: orange_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getheight(context, 11),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: getwidth(context, 27)),
                  height: getheight(context, 197),
                  width: getwidth(context, 315),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        BlocProvider.of<CanteenCubit>(context)
                            .state
                            .currentuser
                            .full_name,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
                      SizedBox(
                        height: getheight(context, 12),
                      ),
                      Text(
                        BlocProvider.of<CanteenCubit>(context)
                            .state
                            .currentuser
                            .email,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: getheight(context, 8),
                      ),
                      Container(
                        color: Colors.black,
                        height: getheight(context, 0.5),
                        width: getwidth(context, 165),
                      ),
                      SizedBox(height: getheight(context, 8)),
                      Text(
                        BlocProvider.of<CanteenCubit>(context)
                            .state
                            .currentuser
                            .phone,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: getheight(context, 8)),
                      Container(
                        color: Colors.black,
                        height: getheight(context, 0.5),
                        width: getwidth(context, 165),
                      ),
                      SizedBox(height: getheight(context, 8)),
                      Container(
                        width: getwidth(context, 285),
                        child: Text(
                          "College: ${BlocProvider.of<CanteenCubit>(context).state.currentuser.College}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                info_containers("Previous Orders", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviousOrders()));
                }),
                info_containers("About Us", () {}),
                info_containers("Report Bug", () {}),
                info_containers("Logout", () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget info_containers(String function_name, Function functoin_work) {
    return GestureDetector(
      onTap: () {
        functoin_work();
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: getwidth(context, 21)),
          height: getheight(context, 60),
          width: getwidth(context, 315),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SizedBox(
                width: getwidth(context, 22),
              ),
              Text(
                function_name,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              SizedBox(
                width: getwidth(context, 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
