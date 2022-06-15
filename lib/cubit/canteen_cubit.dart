import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../backend_data.dart';
import '../main.dart';
import '../widgets.dart';
part 'canteen_state.dart';

class CanteenCubit extends Cubit<CanteenState> {
  CanteenCubit()
      : super(CanteenState(
            cart_items: [],
            paymentstatus: false,
            currentCanteenUser: canteenUser(),
            currentuser: appUser(
                College: "",
                full_name: "",
                email: "",
                phone: "",
                uid: "",
                Roll_no: "")));

  //Emiting Cart items
  void update_cart(List<List> new_cart_list, context) {
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
        paymentstatus: false,
        cart_items: new_cart,
        currentCanteenUser:
            BlocProvider.of<CanteenCubit>(context).state.currentCanteenUser,
        currentuser: BlocProvider.of<CanteenCubit>(context).state.currentuser));
  }

  //Emiting user data
  void get_user_data(uid, context) async {
    dynamic key =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();

    print(uid);

    print(key.data());

    late appUser currentuser;

    currentuser = await appUser(
        College: key.data()["College"],
        full_name: key.data()["Fullname"],
        email: key.data()["email"],
        phone: key.data()["phone"],
        uid: uid,
        Roll_no: key.data()["Rollno"]);

    emit(CanteenState(
        paymentstatus: false,
        cart_items: CanteenCubit().state.cart_items,
        currentuser: currentuser,
        currentCanteenUser: CanteenCubit().state.currentCanteenUser));
  }

  void getCanteenUserData(uid, context) async {
    dynamic key =
        await FirebaseFirestore.instance.collection("Canteens").doc(uid).get();

    late canteenUser currentuser;

    currentuser = canteenUser();
    currentuser.setter(key.data()["Name"], key.data()["email"],
        key.data()["phone"], uid, key.data()["College"]);

    emit(CanteenState(
      paymentstatus: false,
      cart_items: CanteenCubit().state.cart_items,
      currentCanteenUser: currentuser,
      currentuser: appUser(
          College: "",
          full_name: "",
          email: "",
          phone: "",
          uid: uid,
          Roll_no: ""),
    ));
  }

  void set_paystatus(context, status) {
    print("Payment Status is $status now");
    emit(CanteenState(
        cart_items: CanteenCubit().state.cart_items,
        currentuser: BlocProvider.of<CanteenCubit>(context).state.currentuser,
        paymentstatus: status,
        currentCanteenUser:
            BlocProvider.of<CanteenCubit>(context).state.currentCanteenUser));
  }
}

//cart_item Widget!
// ignore: must_be_immutable
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
            child: Stack(
              children: [
                Positioned(
                  top: getheight(context, 27),
                  right: getwidth(context, 7),
                  child: Container(
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
                                .update_cart(cart_list, context);
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
                                .update_cart(cart_list, context);
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
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(photo),
                      radius: getheight(context, 35),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: getheight(context, 10)),
                          Text("Rs. ${price * quantity}/",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 15),
                                  color: orange_color))
                        ]),
                    Spacer(),
                  ],
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

  //Commented code is used if we want data as a stream! Was not working in this case!

    // Stream user_data = await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(uid)
    //     .snapshots();

    // user_data.forEach((element) async {
    //   currentuser = await appUser(
    //       College: element.data()["College"],
    //       full_name: element.data()["Fullname"],
    //       email: element.data()["email"],
    //       phone: element.data()["phone"],
    //       uid: uid,
    //       Roll_no: element.data()["Rollno"]);
    // });
