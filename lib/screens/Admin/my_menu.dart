import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/screens/Admin/admin_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
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
                      Text(
                          "College " +
                              BlocProvider.of<CanteenCubit>(context)
                                  .state
                                  .currentCanteenUser
                                  .getter()[4],
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        BlocProvider.of<CanteenCubit>(context)
                            .state
                            .currentCanteenUser
                            .getter()[0],
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: getheight(context, 25),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _MenuItems(category: "BreakFast", image: 'breakfast'),
                  _MenuItems(category: "Lunch", image: 'lunch'),
                  _MenuItems(category: "Dinner", image: 'dinner'),
                  _MenuItems(category: "Snacks", image: 'snacks'),
                  _MenuItems(category: "Bakery", image: 'bakery'),
                  _MenuItems(category: "Bevrages", image: 'bevrages'),
                ],
              ),
            ),
          ),
        ]));
      },
    );
  }
}

class _MenuItems extends StatelessWidget {
  _MenuItems({required this.category, required this.image});
  String image, category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminItems(
                      category: category,
                    )));
      },
      child: Column(
        children: [
          Container(
              height: getheight(context, 100),
              width: getwidth(context, 325),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(children: [
                SizedBox(width: getwidth(context, 17)),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('images/$image.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  category,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ])),
          SizedBox(
            height: getheight(context, 30),
          )
        ],
      ),
    );
  }
}
