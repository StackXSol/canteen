import 'package:flutter/material.dart';

import '../widgets.dart';

class ScannedDetails extends StatelessWidget {
  const ScannedDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: getheight(context, 60)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_arrow_left)),
                ],
              ),
              SizedBox(
                height: getheight(context, 10),
              ),
              Text(
                "Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(
          height: getheight(context, getheight(context, 20)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 30)),
          child: Column(
            children: [
              Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(image: AssetImage("images/snacks.jpg")))),
              SizedBox(
                height: getheight(context, 20),
              ),
              Text(
                "Items",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: getheight(context, 5)),
              Text(
                "Dal makhni, Butter masala, Cold coffee, butter milk, kdahi paneer",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getheight(context, 20),
              ),
              Text(
                "Uid",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: getheight(context, 5)),
              Text(
                "213234245",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getheight(context, 20),
              ),
              Text(
                "Time",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: getheight(context, 5)),
              Text(
                "18 feb/2022 13:12 pm",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getheight(context, 20),
              ),
              Text(
                "Price",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: getheight(context, 5)),
              Text(
                "300",
                style: TextStyle(
                    color: orange_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )
            ],
          ),
        )
      ]),
    );
  }
}
