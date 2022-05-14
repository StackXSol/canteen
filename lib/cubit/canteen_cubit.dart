import 'package:bloc/bloc.dart';
import 'package:canteen/backend_data.dart';
import 'package:canteen/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../widgets.dart';
part 'canteen_state.dart';

class CanteenCubit extends Cubit<CanteenState> {
  CanteenCubit()
      : super(CanteenState(
            cart_items: [],
            currentuser: appUser(
                College: "",
                full_name: "",
                email: "",
                phone: "",
                uid: "",
                Roll_no: "")));

  void update_cart(List<List> new_cart_list) {
    print(new_cart_list);

    List<Widget> new_cart = [];

    int n = 0;
    for (var i in new_cart_list) {
      new_cart.add(_cartItem(
        price: i[2],
        name: i[0],
        photo: i[1],
        quantity: i[3],
        index: n,
      ));
      n += 1;
    }
    emit(CanteenState(
        cart_items: new_cart, currentuser: CanteenCubit().state.currentuser));
  }

  void get_user_data(uid) async {
    Stream user_data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .snapshots();

    late appUser currentuser;

    user_data.forEach((element) async {
      currentuser = await appUser(
          College: element.data()["College"],
          full_name: element.data()["Fullname"],
          email: element.data()["email"],
          phone: element.data()["phone"],
          uid: uid,
          Roll_no: element.data()["Rollno"]);
      emit(CanteenState(
          cart_items: CanteenCubit().state.cart_items,
          currentuser: currentuser));
    });
  }
}

class _cartItem extends StatelessWidget {
  _cartItem(
      {required this.price,
      required this.index,
      required this.name,
      required this.photo,
      required this.quantity});

  int price, quantity, index;
  String photo, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            padding: EdgeInsets.symmetric(horizontal: getwidth(context, 10)),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(photo),
                  radius: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Text("Rs. ${price * quantity}/",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: orange_color))
                    ]),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: getheight(context, 30)),
                  height: getheight(context, 35),
                  width: getheight(context, 70),
                  decoration: BoxDecoration(
                      color: orange_color,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (cart_list[index][3] != 1) {
                            cart_list[index][3] -= 1;
                          } else {
                            cart_list.removeAt(index);
                          }
                          BlocProvider.of<CanteenCubit>(context)
                              .update_cart(cart_list);
                        },
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: getheight(context, 18),
                        ),
                      ),
                      Text(
                        quantity.toString(),
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          cart_list[index][3] += 1;
                          BlocProvider.of<CanteenCubit>(context)
                              .update_cart(cart_list);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: getheight(context, 18),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getheight(context, 14),
        )
      ],
    );
  }
}
