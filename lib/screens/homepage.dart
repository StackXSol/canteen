import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';
import 'package:canteen/screens/cart.dart';
import 'package:canteen/screens/foodItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPos = 0;
  int pvindex = 0;

  @override
  void initState() {
    super.initState();
    if (!carousel) {
      getCaroselImages();
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Color(0xffF5F5F8),
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                                "Hey ${BlocProvider.of<CanteenCubit>(context).state.currentuser.full_name}",
                                style: TextStyle(
                                    fontSize: textSize.getadaptiveTextSize(
                                        context, 22),
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              height: getheight(context, 12),
                            ),
                            Text("What are you craving for today?",
                                style: TextStyle(
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 14),
                                ))
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
                    height: getheight(context, 32),
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
                          List<Widget> food_items = [];

                          try {
                            var key = await FirebaseFirestore.instance
                                .collection("Canteens")
                                .where("College",
                                    isEqualTo:
                                        BlocProvider.of<CanteenCubit>(context)
                                            .state
                                            .currentuser
                                            .College)
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
                                    image: i.data()["Photo"],
                                    name: i.data()["Name"],
                                    price: i.data()["Price"]));
                              }
                            }
                          } catch (e) {
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
                                                height: getheight(context, 250),
                                              ),
                                              Text(
                                                "Sorry!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 24)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 10),
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
                          List<Widget> food_items = [];

                          try {
                            var key = await FirebaseFirestore.instance
                                .collection("Canteens")
                                .where("College",
                                    isEqualTo:
                                        BlocProvider.of<CanteenCubit>(context)
                                            .state
                                            .currentuser
                                            .College)
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
                                    image: i.data()["Photo"],
                                    name: i.data()["Name"],
                                    price: i.data()["Price"]));
                              }
                            }
                          } catch (e) {
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
                                                height: getheight(context, 250),
                                              ),
                                              Text(
                                                "Sorry!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 24)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 10),
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
                                backgroundImage: AssetImage('images/lunch.jpg'),
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
                          List<Widget> food_items = [];

                          try {
                            var key = await FirebaseFirestore.instance
                                .collection("Canteens")
                                .where("College",
                                    isEqualTo:
                                        BlocProvider.of<CanteenCubit>(context)
                                            .state
                                            .currentuser
                                            .College)
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
                                    image: i.data()["Photo"],
                                    name: i.data()["Name"],
                                    price: i.data()["Price"]));
                              }
                            }
                          } catch (e) {
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
                                                height: getheight(context, 250),
                                              ),
                                              Text(
                                                "Sorry!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 24)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 10),
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
                          List<Widget> food_items = [];
                          try {
                            var key = await FirebaseFirestore.instance
                                .collection("Canteens")
                                .where("College",
                                    isEqualTo:
                                        BlocProvider.of<CanteenCubit>(context)
                                            .state
                                            .currentuser
                                            .College)
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
                                    image: i.data()["Photo"],
                                    name: i.data()["Name"],
                                    price: i.data()["Price"]));
                              }
                            }
                          } catch (e) {
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
                                                height: getheight(context, 250),
                                              ),
                                              Text(
                                                "Sorry!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 24)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 10),
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
                          List<Widget> food_items = [];

                          try {
                            var key = await FirebaseFirestore.instance
                                .collection("Canteens")
                                .where("College",
                                    isEqualTo:
                                        BlocProvider.of<CanteenCubit>(context)
                                            .state
                                            .currentuser
                                            .College)
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
                                    image: i.data()["Photo"],
                                    name: i.data()["Name"],
                                    price: i.data()["Price"]));
                              }
                            }
                          } catch (e) {
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
                                                height: getheight(context, 250),
                                              ),
                                              Text(
                                                "Sorry!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 24)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 10),
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
                          List<Widget> food_items = [];

                          try {
                            var key = await FirebaseFirestore.instance
                                .collection("Canteens")
                                .where("College",
                                    isEqualTo:
                                        BlocProvider.of<CanteenCubit>(context)
                                            .state
                                            .currentuser
                                            .College)
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
                                    image: i.data()["Photo"],
                                    name: i.data()["Name"],
                                    price: i.data()["Price"]));
                              }
                            }
                          } catch (e) {
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
                                                height: getheight(context, 250),
                                              ),
                                              Text(
                                                "Sorry!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: textSize
                                                        .getadaptiveTextSize(
                                                            context, 24)),
                                              ),
                                              SizedBox(
                                                height: getheight(context, 10),
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
            ));
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

class _Item extends StatelessWidget {
  _Item({required this.image, required this.name, required this.price});
  String image, name;
  int price;

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
            child: Row(
              children: [
                CircleAvatar(
                  radius: getheight(context, 35),
                  backgroundImage: NetworkImage(image),
                ),
                SizedBox(
                  width: getwidth(context, 12),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                textSize.getadaptiveTextSize(context, 17)),
                      ),
                      SizedBox(height: getheight(context, 10)),
                      Text("Rs. $price",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 16),
                              color: orange_color))
                    ]),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    bool already = false;
                    for (var i in cart_list) {
                      if (i.contains(name)) {
                        Fluttertoast.showToast(msg: "Already in cart!");
                        already = true;
                      }
                    }
                    !already
                        ? cart_list.add([name, image, price, 1])
                        : cart_list;
                    BlocProvider.of<CanteenCubit>(context)
                        .update_cart(cart_list, context);

                    !already
                        ? Fluttertoast.showToast(msg: "$name Added to cart")
                        : null;
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: getheight(context, 30)),
                      height: getheight(context, 23),
                      width: getwidth(context, 55),
                      decoration: BoxDecoration(
                          color: orange_color,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                textSize.getadaptiveTextSize(context, 14)),
                      ))),
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
