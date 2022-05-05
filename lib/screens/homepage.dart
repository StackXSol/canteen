import 'package:canteen/screens/cart.dart';
import 'package:canteen/screens/items.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        body: Container(
            child: Column(
      children: [
        SizedBox(height: getheight(context, 50)),
        Padding(
          padding: EdgeInsets.only(right: getwidth(context, 40)),
          child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey,
                  size: getheight(context, 24),
                ),
              )),
        ),
        SizedBox(
          height: getheight(context, 19),
        ),
        Padding(
          padding: EdgeInsets.only(left: getwidth(context, 30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Hello Diana",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              SizedBox(
                height: 12,
              ),
              Text("What are you carving for today?")
            ],
          ),
        ),
        SizedBox(
          height: getheight(context, 42),
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
                  margin:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 11.0),
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
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Items()),
                );
              }),
              child: Container(
                height: getheight(context, 113),
                width: getwidth(context, 113),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/food.png')),
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
                height: getheight(context, 113),
                width: getwidth(context, 113),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/food.png')),
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
                height: getheight(context, 113),
                width: getwidth(context, 113),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/food.png')),
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
                height: getheight(context, 113),
                width: getwidth(context, 113),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/food.png')),
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
                height: getheight(context, 113),
                width: getwidth(context, 113),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/food.png')),
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
                height: getheight(context, 113),
                width: getwidth(context, 113),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/food.png')),
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
    )));
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
