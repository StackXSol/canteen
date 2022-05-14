import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets.dart';

class OrdersOfMonth extends StatefulWidget {
  @override
  State<OrdersOfMonth> createState() => _OrdersOfMonthState();
}

class _OrdersOfMonthState extends State<OrdersOfMonth> {
  DateTime now = DateTime.now();
  late String _displayMonth;
  late String _displayYear;

  @override
  void initState() {
    _displayMonth = DateFormat.MMMM().format(now);
    _displayYear = DateFormat.y().format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        SizedBox(height: getheight(context, 60)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.keyboard_arrow_left)),
              Spacer(),
              Text("Orders this month",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Spacer(),
            ],
          ),
        ),
        SizedBox(
          height: getheight(context, 10),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getwidth(context, 40), vertical: 25),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now.subtract(Duration(days: 3650 * 2)),
                    lastDate: now.add(Duration(days: 3650 * 2)),
                  ).then((value) {
                    setState(() {
                      DateTime? now = value;
                      _displayYear = value!.year.toString();
                      _displayMonth = DateFormat.MMMM().format(value);
                    });
                  });
                },
                child: Text("${_displayMonth} ${_displayYear}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    /// going to previous date
                    setState(() {
                      now = now.subtract(Duration(days: 30));
                      _displayMonth = DateFormat.MMMM().format(now);
                    });
                  },
                  child: Icon(Icons.keyboard_arrow_left)),
              SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    //////// going to forward date
                    setState(() {
                      now = now.add(Duration(days: 30));
                      _displayMonth = DateFormat.MMMM().format(now);
                    });
                  },
                  child: Icon(Icons.keyboard_arrow_right))
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [_Orders(), _Orders(), _Orders()]
                // widget.food_items

                ),
          ),
        ),
        SizedBox(
          height: getheight(context, 10),
        )
      ],
    )));
  }
}

class _Orders extends StatelessWidget {
  // _Orders({required this.total_price, required this.oid});

  // int total_price, oid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ////// /////////
          },
          child: Container(
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
                    // backgroundImage: NetworkImage(image),
                    backgroundImage: NetworkImage(
                        "https://www.listchallenges.com/f/items/57fc372f-9ae7-44e7-b35d-68c8d5bd8df0.jpg"),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order 1334",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                            // "Rs. $price",
                            "Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: orange_color))
                      ]),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: getheight(context, 25)),
                    child: Text("2000/-",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: orange_color)),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: getheight(context, 25),
        )
      ],
    );
  }
}
