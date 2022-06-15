import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import '../widgets.dart';

class SelectCanteen extends StatefulWidget {
  SelectCanteen({required this.canteens});
  List canteens;

  @override
  State<SelectCanteen> createState() => _SelectCanteenState();
}

class _SelectCanteenState extends State<SelectCanteen> {
  List<Widget> canteens = [];

  @override
  void initState() {
    disp_canteens();
    super.initState();
  }

  void disp_canteens() {
    for (var element in widget.canteens) {
      canteens.add(
        CanteenWidget(
            name: element.data()["Name"], college: element.data()["College"]),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      body: Column(
        children: [
          SizedBox(height: getheight(context, 55)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
            child: Row(children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Icon(Icons.keyboard_arrow_left),
                  )),
              SizedBox(
                width: getwidth(context, 75),
              ),
              Text("Select Canteen",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textSize.getadaptiveTextSize(context, 18))),
            ]),
          ),
          SizedBox(
            height: getheight(context, 25),
          ),
          Column(children: canteens)
        ],
      ),
    );
  }
}

class CanteenWidget extends StatelessWidget {
  CanteenWidget({required this.name, required this.college});

  String name, college;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image(
              height: 65,
              width: 65,
              image: AssetImage("images/fastfood.png"),
            ),
          ),
          SizedBox(
            width: getwidth(context, 15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: orange_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              SizedBox(
                height: getheight(context, 10),
              ),
              Text(
                college,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              canteen = name;
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "$name selected!");
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: getheight(context, 40)),
                height: getheight(context, 23),
                // width: getwidth(context, 55),
                decoration: BoxDecoration(
                    color: orange_color,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  "Select",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: textSize.getadaptiveTextSize(context, 14)),
                ))),
          ),
          SizedBox(
            width: getwidth(context, 10),
          )
        ],
      ),
    );
  }
}
