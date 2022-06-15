import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/canteen_cubit.dart';
import '../main.dart';
import '../widgets.dart';
import 'cart.dart';

class Food_Items extends StatefulWidget {
  Food_Items(
      {required this.food_type,
      required this.food_items,
      required this.canteenid});
  String food_type;
  String canteenid;
  List<Widget> food_items;

  @override
  State<Food_Items> createState() => _Food_ItemsState();
}

class _Food_ItemsState extends State<Food_Items> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Color(0xffF5F5F8),
            body: Container(
                child: Column(
              children: [
                SizedBox(height: getheight(context, 60)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: Icon(Icons.keyboard_arrow_left),
                          )),
                      Spacer(),
                      Text(widget.food_type,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 18))),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Cart()),
                            );
                          },
                          child: CartWid()),
                    ],
                  ),
                ),
                SizedBox(
                  height: getheight(context, getheight(context, 30)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: widget.food_items),
                  ),
                ),
                SizedBox(
                  height: getheight(context, 10),
                )
              ],
            )));
      },
    );
  }
}
