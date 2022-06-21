import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../cubit/canteen_cubit.dart';
import '../../main.dart';
import '../../widgets.dart';

class AdminItems extends StatefulWidget {
  AdminItems({required this.category});
  String category;

  @override
  State<AdminItems> createState() => _AdminItemsState();
}

class _AdminItemsState extends State<AdminItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: [
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
            Text(widget.category,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize.getadaptiveTextSize(context, 18))),
          ],
        ),
      ),
      SizedBox(
        height: getheight(context, 40),
      ),
      Expanded(
          child: SingleChildScrollView(
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection("Canteens")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Menu")
                .doc(widget.category)
                .collection("Items")
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<_Item> _itemlist = [];
                for (var i in snapshot.data.docs) {
                  print(i.id);
                  _itemlist.add(_Item(
                    category: widget.category,
                    toggle: i.data()["Status"],
                    ontap: () {},
                    docid: i.id,
                    image: i.data()["Photo"],
                    name: i.data()["Name"],
                  ));
                }
                return Column(
                    children: _itemlist.length != 0
                        ? _itemlist
                        : [
                            SizedBox(
                              height: getheight(context, 250),
                            ),
                            Center(
                              child: Text(
                                "No Items",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: textSize.getadaptiveTextSize(
                                        context, 22)),
                              ),
                            )
                          ]);
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: getheight(context, 250),
                    ),
                    Text("Fetching...")
                  ],
                );
              }
            }),
      )),
      SizedBox(
        height: getheight(context, 60),
      )
    ])));
  }
}

class _Item extends StatefulWidget {
  _Item(
      {required this.toggle,
      required this.ontap,
      required this.name,
      required this.docid,
      required this.category,
      required this.image});
  late Function ontap;

  String name, image, docid, category;
  bool toggle;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  int price = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(          
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
            padding: EdgeInsets.symmetric(horizontal: getheight(context, 10), vertical: getheight(context, 12)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: getheight(context, 32),
                  // backgroundImage: NetworkImage(image),
                  backgroundImage: NetworkImage(widget.image),
                ),
                SizedBox(
                  width: getwidth(context, 12),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: getwidth(context, 170),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 15)),
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Form(
                                      // key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: textSize
                                                    .getadaptiveTextSize(
                                                        context, 20)),
                                          ),
                                          SizedBox(
                                            height: getheight(context, 15),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                                initialValue: widget.name,
                                                validator: (value) {
                                                  if (value.toString().length <
                                                      4) {
                                                    return "Enter valid Name!";
                                                  }
                                                  return null;
                                                },
                                                onChanged: ((value) {
                                                  widget.name = value;
                                                }),
                                                style: TextStyle(
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 17),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30)),
                                                    hintText: "Food Name",
                                                    hintStyle: TextStyle(
                                                        fontSize: textSize
                                                            .getadaptiveTextSize(
                                                                context, 16),
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.5)))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                                initialValue: price.toString(),
                                                onChanged: (value) {
                                                  price = int.parse(value);
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 17),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                decoration: InputDecoration(
                                                    hintText: "Enter price",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30)),
                                                    hintStyle: TextStyle(
                                                        fontSize: textSize
                                                            .getadaptiveTextSize(
                                                                context, 16),
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.5)))),
                                          ),
                                          SizedBox(
                                              height: getheight(context, 20)),
                                          GestureDetector(
                                            onTap: () async {
                                              print(widget.docid);
                                              try {
                                                FirebaseFirestore.instance
                                                    .collection("Canteens")
                                                    .doc(BlocProvider.of<
                                                                CanteenCubit>(
                                                            context)
                                                        .state
                                                        .currentCanteenUser
                                                        .getter()[3])
                                                    .collection("Menu")
                                                    .doc(widget.category)
                                                    .collection("Items")
                                                    .doc(widget.docid)
                                                    .set({
                                                  "Name": widget.name,
                                                  "Price": price
                                                }, SetOptions(merge: true));
                                                Fluttertoast.showToast(
                                                    msg: "Price updated!");
                                                Navigator.pop(context);
                                              } catch (e) {
                                                print(await e);
                                              }
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
                                                  "Done",
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
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text("Edit",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 15),
                                color: orange_color)),
                      )
                    ]),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                      top: getheight(context, 30),
                      right: getwidth(context, 15)),
                  child: FlutterSwitch(
                      height: getheight(context, 25),
                      width: getwidth(context, 45),
                      toggleColor: Colors.white,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.greenAccent,
                      value: widget.toggle,
                      onToggle: (value) {
                        setState(() {
                          widget.toggle = !widget.toggle;
                          FirebaseFirestore.instance
                              .collection("Canteens")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("Menu")
                              .doc(widget.category)
                              .collection("Items")
                              .doc(widget.docid)
                              .set({"Status": widget.toggle},
                                  SetOptions(merge: true));
                          print(widget.toggle);
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getheight(context, 20),
        )
      ],
    );
  }
}
