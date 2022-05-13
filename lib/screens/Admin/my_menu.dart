import 'package:flutter/material.dart';
import '../../widgets.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({Key? key}) : super(key: key);

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
      SingleChildScrollView(
        child: Column(
          children: [
            _MenuItems(),
            _MenuItems(),
            _MenuItems(),
            _MenuItems(),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          /////////// scan QR ////////////////
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

class _MenuItems extends StatelessWidget {
  const _MenuItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: getheight(context, 100),
            width: getwidth(context, 315),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(children: [
              SizedBox(width: getwidth(context, 17)),
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('images/snacks.jpg'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Breakfast",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ])),
        SizedBox(
          height: getheight(context, 25),
        )
      ],
    );
  }
}
