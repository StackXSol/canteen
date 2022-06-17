import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../cubit/canteen_cubit.dart';
import '../main.dart';
import '../widgets.dart';
import 'canteens.dart';
import 'cart.dart';
import 'foodItems.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPos = 0;
  int pvindex = 0;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CanteenCubit>(context).update_cart(cart_list, context);
    if (!carousel) {
      getCaroselImages();
    }
    if (!canteen_bool) {
      get_canteens();
    }
  }

  Future<void> getCaroselImages() async {
    images.clear();

    var key = await FirebaseFirestore.instance
        .collection("AppData")
        .doc("Images")
        .get();

    for (var element in (key.data() as dynamic)["images"]) {
      images.add(element);
    }

    carousel = true;

    setState(() {});
  }

  Future<void> get_canteens() async {
    canteens.clear();
    var key = await FirebaseFirestore.instance.collection("Canteens").get();
    for (var element in key.docs) {
      if (element.data()["College"] ==
          BlocProvider.of<CanteenCubit>(context).state.currentuser.College) {
        canteens.add(element);
      }
    }

    if (canteens.length == 0) {
      setState(() {
        canteen = "No canteen found!";
      });
    } else if (canteens.length == 1) {
      setState(() {
        canteen = canteens[0].data()["Name"];
      });
    }

    canteen_bool = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: orange_color,
          ),
          opacity: 0.1,
          child: Scaffold(
              backgroundColor: Color(0xffF5F5F8),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getheight(context, 65)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getwidth(context, 22)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Hey ${BlocProvider.of<CanteenCubit>(context).state.currentuser.full_name}",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 22),
                                      fontWeight: FontWeight.w900)),
                              SizedBox(
                                height: getheight(context, 12),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (canteens.length == 0) {
                                    Fluttertoast.showToast(msg: "No canteens!");
                                  } else if (canteens.length == 1) {
                                    print("reseted!");
                                    Fluttertoast.showToast(
                                        msg: "There is only one canteen!");
                                  } else {
                                    print(cart_list);
                                    if (!cart_list.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Order/delete items in cart to switch canteen!");
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectCanteen(
                                                    canteens: canteens,
                                                  )));
                                    }
                                  }
                                },
                                child: Row(
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        canteen,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: orange_color,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cart()));
                            },
                            child: CartWid(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getheight(context, 26),
                    ),
                    Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: images.length,
                          options: CarouselOptions(
                              autoPlayCurve: Curves.fastOutSlowIn,
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPos = index;
                                });
                              }),
                          itemBuilder: (context, index, pvindex) {
                            return MyImageView(images[index]);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          child: AnimatedSmoothIndicator(
                            activeIndex: currentPos,
                            count: images.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: orange_color,
                                dotWidth: getheight(context, 8),
                                dotHeight: getheight(context, 8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getheight(context, 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (() async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });

                            List<Widget> food_items = [];

                            try {
                              var key = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .where("Name", isEqualTo: canteen)
                                  .get();
                              canteenId = key.docs.first.id;
                              var key2 = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .doc(key.docs.first.id)
                                  .collection("Menu")
                                  .doc("BreakFast")
                                  .collection("Items")
                                  .get();

                              for (var i in key2.docs) {
                                if (i.data()["Status"]) {
                                  food_items.add(_Item(
                                      alreadyitem: _check(i.data()["Name"]),
                                      image: i.data()["Photo"],
                                      name: i.data()["Name"],
                                      price: i.data()["Price"]));
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                              food_items = [
                                SizedBox(
                                  height: getheight(context, 200),
                                ),
                                Text(
                                  "College Canteen\nNot Found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 24)),
                                ),
                                SizedBox(
                                  height: getheight(context, 15),
                                ),
                                Text(
                                  "We are expanding and will let\nyou know when we will be in your college!",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                  textAlign: TextAlign.center,
                                )
                              ];
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food_Items(
                                        canteenid: canteenId,
                                        food_type: "Breakfast",
                                        food_items: food_items.length != 0
                                            ? food_items
                                            : [
                                                SizedBox(
                                                  height:
                                                      getheight(context, 250),
                                                ),
                                                Text(
                                                  "Sorry!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 24)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Text(
                                                  "Your college canteen has not\nadded any item yet!",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                      )),
                            );
                          }),
                          child: Container(
                            width: getwidth(context, 113),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: getheight(context, 45),
                                  backgroundImage:
                                      AssetImage('images/breakfast.jpg'),
                                ),
                                SizedBox(
                                  height: getheight(context, 5),
                                ),
                                Text(
                                  "Breakfast",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });

                            List<Widget> food_items = [];

                            try {
                              var key = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .where("Name", isEqualTo: canteen)
                                  .get();
                              canteenId = key.docs.first.id;
                              var key2 = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .doc(key.docs.first.id)
                                  .collection("Menu")
                                  .doc("Lunch")
                                  .collection("Items")
                                  .get();

                              for (var i in key2.docs) {
                                if (i.data()["Status"]) {
                                  food_items.add(_Item(
                                      alreadyitem: _check(i.data()["Name"]),
                                      image: i.data()["Photo"],
                                      name: i.data()["Name"],
                                      price: i.data()["Price"]));
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                              food_items = [
                                SizedBox(
                                  height: getheight(context, 200),
                                ),
                                Text(
                                  "College Canteen\nNot Found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 24)),
                                ),
                                SizedBox(
                                  height: getheight(context, 15),
                                ),
                                Text(
                                  "We are expanding and will let\nyou know when we will be in your college!",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                  textAlign: TextAlign.center,
                                )
                              ];
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food_Items(
                                        canteenid: canteenId,
                                        food_type: "Lunch",
                                        food_items: food_items.length != 0
                                            ? food_items
                                            : [
                                                SizedBox(
                                                  height:
                                                      getheight(context, 250),
                                                ),
                                                Text(
                                                  "Sorry!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 24)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Text(
                                                  "Your college canteen has not\nadded any item yet!",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                      )),
                            );
                          }),
                          child: Container(
                            width: getwidth(context, 113),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: getheight(context, 45),
                                  backgroundImage:
                                      AssetImage('images/lunch.jpg'),
                                ),
                                SizedBox(
                                  height: getheight(context, 5),
                                ),
                                Text("Lunch",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });

                            List<Widget> food_items = [];

                            try {
                              var key = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .where("Name", isEqualTo: canteen)
                                  .get();
                              canteenId = key.docs.first.id;
                              var key2 = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .doc(key.docs.first.id)
                                  .collection("Menu")
                                  .doc("Dinner")
                                  .collection("Items")
                                  .get();

                              for (var i in key2.docs) {
                                if (i.data()["Status"]) {
                                  food_items.add(_Item(
                                      alreadyitem: _check(i.data()["Name"]),
                                      image: i.data()["Photo"],
                                      name: i.data()["Name"],
                                      price: i.data()["Price"]));
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                              food_items = [
                                SizedBox(
                                  height: getheight(context, 200),
                                ),
                                Text(
                                  "College Canteen\nNot Found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 24)),
                                ),
                                SizedBox(
                                  height: getheight(context, 15),
                                ),
                                Text(
                                  "We are expanding and will let\nyou know when we will be in your college!",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                  textAlign: TextAlign.center,
                                )
                              ];
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food_Items(
                                        canteenid: canteenId,
                                        food_type: "Dinner",
                                        food_items: food_items.length != 0
                                            ? food_items
                                            : [
                                                SizedBox(
                                                  height:
                                                      getheight(context, 250),
                                                ),
                                                Text(
                                                  "Sorry!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 24)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Text(
                                                  "Your college canteen has not\nadded any item yet!",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                      )),
                            );
                          }),
                          child: Container(
                            width: getwidth(context, 113),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: getheight(context, 45),
                                  backgroundImage:
                                      AssetImage('images/dinner.jpg'),
                                ),
                                SizedBox(
                                  height: getheight(context, 5),
                                ),
                                Text(
                                  "Dinner",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
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
                          onTap: (() async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });

                            List<Widget> food_items = [];
                            try {
                              var key = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .where("Name", isEqualTo: canteen)
                                  .get();
                              canteenId = key.docs.first.id;
                              var key2 = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .doc(key.docs.first.id)
                                  .collection("Menu")
                                  .doc("Snacks")
                                  .collection("Items")
                                  .get();

                              for (var i in key2.docs) {
                                if (i.data()["Status"]) {
                                  food_items.add(_Item(
                                      alreadyitem: _check(i.data()["Name"]),
                                      image: i.data()["Photo"],
                                      name: i.data()["Name"],
                                      price: i.data()["Price"]));
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                              food_items = [
                                SizedBox(
                                  height: getheight(context, 200),
                                ),
                                Text(
                                  "College Canteen\nNot Found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 24)),
                                ),
                                SizedBox(
                                  height: getheight(context, 15),
                                ),
                                Text(
                                  "We are expanding and will let\nyou know when we will be in your college!",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                  textAlign: TextAlign.center,
                                )
                              ];
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food_Items(
                                        canteenid: canteenId,
                                        food_type: "Snacks",
                                        food_items: food_items.length != 0
                                            ? food_items
                                            : [
                                                SizedBox(
                                                  height:
                                                      getheight(context, 250),
                                                ),
                                                Text(
                                                  "Sorry!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 24)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Text(
                                                  "Your college canteen has not\nadded any item yet!",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                      )),
                            );
                          }),
                          child: Container(
                            // height: getheight(context, 120),
                            width: getwidth(context, 113),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: getheight(context, 45),
                                  backgroundImage:
                                      AssetImage('images/snacks.jpg'),
                                ),
                                SizedBox(
                                  height: getheight(context, 5),
                                ),
                                Text(
                                  "Snacks",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });

                            List<Widget> food_items = [];

                            try {
                              var key = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .where("Name", isEqualTo: canteen)
                                  .get();
                              canteenId = key.docs.first.id;
                              var key2 = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .doc(key.docs.first.id)
                                  .collection("Menu")
                                  .doc("Bakery")
                                  .collection("Items")
                                  .get();

                              for (var i in key2.docs) {
                                if (i.data()["Status"]) {
                                  food_items.add(_Item(
                                      alreadyitem: _check(i.data()["Name"]),
                                      image: i.data()["Photo"],
                                      name: i.data()["Name"],
                                      price: i.data()["Price"]));
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                              food_items = [
                                SizedBox(
                                  height: getheight(context, 200),
                                ),
                                Text(
                                  "College Canteen\nNot Found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 24)),
                                ),
                                SizedBox(
                                  height: getheight(context, 15),
                                ),
                                Text(
                                  "We are expanding and will let\nyou know when we will be in your college!",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                  textAlign: TextAlign.center,
                                )
                              ];
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food_Items(
                                        canteenid: canteenId,
                                        food_type: "Bakery",
                                        food_items: food_items.length != 0
                                            ? food_items
                                            : [
                                                SizedBox(
                                                  height:
                                                      getheight(context, 250),
                                                ),
                                                Text(
                                                  "Sorry!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 24)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Text(
                                                  "Your college canteen has not\nadded any item yet!",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                      )),
                            );
                          }),
                          child: Container(
                            // height: getheight(context, 120),
                            width: getwidth(context, 113),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: getheight(context, 45),
                                  backgroundImage:
                                      AssetImage('images/bakery.jpg'),
                                ),
                                SizedBox(
                                  height: getheight(context, 5),
                                ),
                                Text(
                                  "Bakery",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });

                            List<Widget> food_items = [];

                            try {
                              var key = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .where("Name", isEqualTo: canteen)
                                  .get();
                              canteenId = key.docs.first.id;
                              var key2 = await FirebaseFirestore.instance
                                  .collection("Canteens")
                                  .doc(key.docs.first.id)
                                  .collection("Menu")
                                  .doc("Bevrages")
                                  .collection("Items")
                                  .get();

                              for (var i in key2.docs) {
                                if (i.data()["Status"]) {
                                  food_items.add(_Item(
                                      alreadyitem: _check(i.data()["Name"]),
                                      image: i.data()["Photo"],
                                      name: i.data()["Name"],
                                      price: i.data()["Price"]));
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                print("spinner false");
                              });
                              food_items = [
                                SizedBox(
                                  height: getheight(context, 200),
                                ),
                                Text(
                                  "College Canteen\nNot Found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 24)),
                                ),
                                SizedBox(
                                  height: getheight(context, 15),
                                ),
                                Text(
                                  "We are expanding and will let\nyou know when we will be in your college!",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                  textAlign: TextAlign.center,
                                )
                              ];
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food_Items(
                                        canteenid: canteenId,
                                        food_type: "Beverages",
                                        food_items: food_items.length != 0
                                            ? food_items
                                            : [
                                                SizedBox(
                                                  height:
                                                      getheight(context, 250),
                                                ),
                                                Text(
                                                  "Sorry!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 24)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Text(
                                                  "Your college canteen has not\nadded any item yet!",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                      )),
                            );
                          }),
                          child: Container(
                            // height: getheight(context, 120),
                            width: getwidth(context, 113),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: getheight(context, 45),
                                  backgroundImage:
                                      AssetImage('images/bevrages.jpg'),
                                ),
                                SizedBox(
                                  height: getheight(context, 5),
                                ),
                                Text(
                                  "Beverages",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getheight(context, 10),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: getheight(context, 195),
        width: getwidth(context, 335),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FittedBox(fit: BoxFit.cover, child: Image.network(imgPath)),
        ));
  }
}

class _Item extends StatefulWidget {
  _Item(
      {required this.image,
      required this.name,
      required this.price,
      required this.alreadyitem});
  String image, name;
  int price;
  bool alreadyitem;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            child: Stack(
              children: [
                Positioned(
                  right: getwidth(context, 7),
                  top: getheight(context, 37),
                  child: GestureDetector(
                    onTap: () {
                      bool _already = false;
                      for (var i in cart_list) {
                        if (i.contains(widget.name)) {
                          Fluttertoast.showToast(msg: "Already in cart!");
                          _already = true;
                          break;
                        }
                      }
                      !_already
                          ? cart_list
                              .add([widget.name, widget.image, widget.price, 1])
                          : cart_list;
                      BlocProvider.of<CanteenCubit>(context)
                          .update_cart(cart_list, context);

                      setState(() {
                        widget.alreadyitem = true;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(top: getheight(context, 30)),
                        height: getheight(context, 23),
                        // width: getwidth(context, 55),
                        decoration: BoxDecoration(
                            color: !widget.alreadyitem
                                ? orange_color
                                : Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          !widget.alreadyitem ? "Add +" : "In Cart  🛒",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 14)),
                        ))),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: getheight(context, 35),
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
                            width: getwidth(context, 150),
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: getheight(context, 10)),
                          Text("Rs. ${widget.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 16),
                                  color: orange_color))
                        ]),
                    Spacer(),
                  ],
                ),
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

bool _check(String name) {
  for (var i in cart_list) {
    if (i.contains(name)) {
      return true;
    }
  }
  return false;
}
