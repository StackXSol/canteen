import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/canteen_cubit.dart';
import 'main.dart';

double getheight(context, value) {
  return MediaQuery.of(context).size.height * (value / 812);
}

double getwidth(context, value) {
  return MediaQuery.of(context).size.width * (value / 375);
}

Color orange_color = Color.fromARGB(255, 255, 110, 57);

class CartWid extends StatelessWidget {
  const CartWid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.grey,
            size: getheight(context, 32),
          ),
        ),
        Positioned(
          top: getheight(context, 14),
          left: getwidth(context, 22),
          child: CircleAvatar(
            radius: getheight(context, 15),
            backgroundColor: Colors.transparent,
            child: Text(
              BlocProvider.of<CanteenCubit>(context)
                          .state
                          .cart_items
                          .length
                          .toString() !=
                      "0"
                  ? BlocProvider.of<CanteenCubit>(context)
                      .state
                      .cart_items
                      .length
                      .toString()
                  : "",
              style: TextStyle(
                  color: orange_color,
                  fontSize: textSize.getadaptiveTextSize(context, 16),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    return (value / 812) * MediaQuery.of(context).size.height;
  }
}
