import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../widgets.dart';

class AdminItems extends StatefulWidget {
  AdminItems({Key? key}) : super(key: key);

  @override
  State<AdminItems> createState() => _AdminItemsState();
}

class _AdminItemsState extends State<AdminItems> {
  bool toggle = true;
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
                child: Icon(Icons.keyboard_arrow_left)),
            Spacer(),
            Text("Breakfast",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Spacer(),
          ],
        ),
      ),
      SizedBox(
        height: getheight(context, 40),
      ),
      Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _Item(toggle: toggle, ontap: () {}),
            _Item(toggle: toggle, ontap: () {}),
            _Item(toggle: toggle, ontap: () {}),
            _Item(toggle: toggle, ontap: () {}),
          ],
        ),
      )),
      SizedBox(
        height: getheight(context, 60),
      )
    ])));
  }
}

class _Item extends StatefulWidget {
  _Item({required this.toggle, required this.ontap});
  late Function ontap;
  bool toggle;

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
                        "Vada Pav",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Text("Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: orange_color))
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
