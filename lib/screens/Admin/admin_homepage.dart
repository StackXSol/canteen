import 'package:canteen/screens/Admin/add_food.dart';
import 'package:canteen/screens/Admin/my_menu.dart';
import 'package:canteen/screens/Admin/orders_this_month.dart';
import 'package:canteen/screens/Admin/qrScanner.dart';
import 'package:flutter/material.dart';

import '../../widgets.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(height: getheight(context, 65)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 22)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Canteen Name",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 13,
                  ),
                  Text("Canteen Address"),
                ],
              ),
            ],
          )),
      SizedBox(
        height: getheight(context, 25),
      ),
      Container(
        height: getheight(context, 100),
        width: getwidth(context, 300),
        decoration: BoxDecoration(
            color: Color(0xFFFFDBDB), borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's revenue:-",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text("\u{20B9} 6000",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            )
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
              height: getheight(context, 147),
              width: getwidth(context, 148),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
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
              height: getheight(context, 147),
              width: getwidth(context, 148),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
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
              height: getheight(context, 147),
              width: getwidth(context, 148),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
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
                    "Orders this\n    month",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (() {
              // Orders today
            }),
            child: Container(
              height: getheight(context, 147),
              width: getwidth(context, 148),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
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
                    "Orders today",
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
              MaterialPageRoute(builder: (context) => QRViewExample()));
        },
        child: Container(
          height: getheight(context, 58),
          width: getwidth(context, 275),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: orange_color),
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
    ]));
  }
}
