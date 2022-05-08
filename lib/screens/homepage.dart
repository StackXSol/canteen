import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';
import 'package:canteen/screens/cart.dart';
import 'package:canteen/screens/foodItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPos = 0;
  int pvindex = 0;
  List<String> listPaths = [
    "images/Splashscreen.png",
    "images/Splashscreen.png",
    "images/Splashscreen.png",
    "images/Splashscreen.png",
    "images/Splashscreen.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F8),
        body: Column(
          children: [
            SizedBox(height: getheight(context, 65)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getwidth(context, 22)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${currentUser.full_name}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: 12,
                      ),
                      Text("What are you carving for today?")
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.grey,
                      size: getheight(context, 28),
                    ),
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
                  itemCount: listPaths.length,
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
                    return MyImageView(listPaths[index]);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listPaths.map((url) {
                    int index = listPaths.indexOf(url);
                    return Container(
                      width: 6.0,
                      height: 6.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 11.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? Color(0xFFA06784).withOpacity(0.15)
                              : Color(0xFFA06784)),
                    );
                  }).toList(),
                )
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
                          .where("College", isEqualTo: currentUser.College)
                          .get();
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
                      food_items.add(Text("No Canteen of your college found!"));
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Food_Items(
                                food_type: "Breakfast",
                                food_items: food_items,
                              )),
                    );
                  }),
                  child: Container(
                    height: getheight(context, 120),
                    width: getwidth(context, 113),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('images/breakfast.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Breakfast",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    // Lunch
                  }),
                  child: Container(
                    height: getheight(context, 120),
                    width: getwidth(context, 113),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('images/lunch.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Lunch",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    // Dinner
                  }),
                  child: Container(
                    height: getheight(context, 120),
                    width: getwidth(context, 113),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('images/dinner.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Dinner",
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
                    // Snacks
                  }),
                  child: Container(
                    height: getheight(context, 120),
                    width: getwidth(context, 113),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('images/snacks.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Snacks",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    // Bakery
                  }),
                  child: Container(
                    height: getheight(context, 120),
                    width: getwidth(context, 113),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('images/bakery.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Bakery",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    // Beverages
                  }),
                  child: Container(
                    height: getheight(context, 120),
                    width: getwidth(context, 113),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('images/bevrages.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Beverages",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: getheight(context, 188),
        width: getwidth(context, 321),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(imgPath),
          ),
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
                  radius: 35,
                  backgroundImage: NetworkImage(image),
                ),
                SizedBox(
                  width: 12,
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
                      Text("Rs. $price",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: orange_color))
                    ]),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    cart_list.add([name, image, price, 1]);
                    BlocProvider.of<CanteenCubit>(context)
                        .update_cart(cart_list);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: getheight(context, 30)),
                    height: getheight(context, 23),
                    width: getheight(context, 55),
                    decoration: BoxDecoration(
                        color: orange_color,
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: getheight(context, 14),
                    ),
                  ),
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
