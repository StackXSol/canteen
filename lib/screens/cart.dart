import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';
import 'package:canteen/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffF5F5F8),
          body: Container(
            child: Column(
              children: [
                SizedBox(height: getheight(context, 50)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.keyboard_arrow_left)),
                      Spacer(),
                      Text("Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Spacer(),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: orange_color,
                        size: getheight(context, 24),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getheight(context, getheight(context, 40)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: BlocProvider.of<CanteenCubit>(context)
                            .state
                            .cart_items),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    height: getheight(context, 70),
                    width: getwidth(context, 314),
                    decoration: BoxDecoration(
                        color: orange_color,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Complete Order",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xfff6f6f9)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
