import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:init/backend_data.dart';
import 'package:init/screens/reportBug.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/canteen_cubit.dart';
import '../main.dart';
import '../widgets.dart';
import 'Authentication/login_signup.dart';
import 'Orders/previous.orders.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  AdaptiveTextSize textSize = AdaptiveTextSize();

  String name = "";
  String phone = "";
  bool showSpinner = false;

  var collegelist = ["Select College"];

  // @override
  // void initState() {
  //   fetch_colleges();
  //   super.initState();
  // }

  Future<void> fetch_colleges() async {
    collegelist = ["Select College"];

    var key = await FirebaseFirestore.instance
        .collection("CollegeList")
        .doc("Colleges")
        .get();

    for (var i in (key.data() as dynamic)["CollegeList"]) {
      collegelist.add(i.toString());
    }

    print(collegelist);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String name =
        BlocProvider.of<CanteenCubit>(context).state.currentuser.full_name;
    String phone =
        BlocProvider.of<CanteenCubit>(context).state.currentuser.phone;
    String dropdownValue =
        BlocProvider.of<CanteenCubit>(context).state.currentuser.College;

    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffF5F5F8),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getheight(context, 55)),
                    Row(
                      children: [
                        SizedBox(
                          width: getwidth(context, 35),
                        ),
                        Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 26),
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer()
                      ],
                    ),
                    SizedBox(
                      height: getheight(context, 40),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getwidth(context, 35),
                          right: getwidth(context, 47)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Details",
                            style: TextStyle(
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 16),
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await fetch_colleges();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          padding: EdgeInsets.all(18),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  "Edit Details",
                                                  style: TextStyle(
                                                      fontSize: textSize
                                                          .getadaptiveTextSize(
                                                              context, 16),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                      initialValue: name,
                                                      validator: (value) {
                                                        if (value
                                                                    .toString()
                                                                    .length <
                                                                4 ||
                                                            value
                                                                    .toString()
                                                                    .length >
                                                                18) {
                                                          return "Enter valid Name!";
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: ((value) {
                                                        name = value;
                                                      }),
                                                      style: TextStyle(
                                                        fontSize: textSize
                                                            .getadaptiveTextSize(
                                                                context, 14),
                                                      ),
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.all(
                                                                  10),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          hintText:
                                                              "Enter name",
                                                          hintStyle: TextStyle(
                                                              fontSize: textSize
                                                                  .getadaptiveTextSize(
                                                                      context,
                                                                      14),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5)))),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                      initialValue: phone,
                                                      validator: (value) {
                                                        if (value
                                                                .toString()
                                                                .length !=
                                                            10) {
                                                          return "Enter valid Number!";
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: (value) {
                                                        phone = value;
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                        fontSize: textSize
                                                            .getadaptiveTextSize(
                                                                context, 14),
                                                      ),
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          hintText:
                                                              "Phone number",
                                                          hintStyle: TextStyle(
                                                              fontSize: textSize
                                                                  .getadaptiveTextSize(
                                                                      context,
                                                                      14),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5)))),
                                                ),
                                                SizedBox(
                                                  height:
                                                      getheight(context, 10),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  padding: EdgeInsets.all(10),
                                                  height:
                                                      getheight(context, 50),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.9)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: DropdownButton<String>(
                                                    menuMaxHeight: 260,
                                                    isExpanded: true,
                                                    value: dropdownValue,
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    underline: Container(
                                                      height: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!;
                                                      });
                                                    },
                                                    items: collegelist.map<
                                                        DropdownMenuItem<
                                                            String>>((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        getheight(context, 20)),
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      showSpinner = true;
                                                      print("spinner true");
                                                    });
                                                    print(dropdownValue);
                                                    if (_formKey.currentState!
                                                            .validate() &&
                                                        dropdownValue !=
                                                            "Select College") {
                                                      FirebaseFirestore.instance
                                                          .collection("Users")
                                                          .doc(BlocProvider.of<
                                                                      CanteenCubit>(
                                                                  context)
                                                              .state
                                                              .currentuser
                                                              .uid)
                                                          .set(
                                                              {
                                                            "Fullname": name,
                                                            "phone": phone,
                                                            "College":
                                                                dropdownValue,
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      BlocProvider.of<
                                                                  CanteenCubit>(
                                                              context)
                                                          .get_user_data(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              context);
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        showSpinner = false;
                                                        print("spinner true");
                                                      });
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Details Updated!");
                                                      canteens.clear();
                                                      canteen =
                                                          "Select Canteen";
                                                      canteen_bool = false;
                                                      //change this
                                                      cart_list.clear();
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please select a college!");
                                                      setState(() {
                                                        showSpinner = false;
                                                        print("spinner false");
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height:
                                                        getheight(context, 50),
                                                    width:
                                                        getwidth(context, 100),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: orange_color),
                                                    child: Center(
                                                      child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: textSize
                                                                .getadaptiveTextSize(
                                                                    context,
                                                                    17)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  });
                            },
                            child: Text(
                              "edit",
                              style: TextStyle(
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 15),
                                color: orange_color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getheight(context, 11),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(left: getwidth(context, 27)),
                      // height: getheight(context, 197),
                      width: getwidth(context, 315),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffffffff),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            BlocProvider.of<CanteenCubit>(context)
                                .state
                                .currentuser
                                .full_name,
                            style: TextStyle(
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 25),
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000)),
                          ),
                          SizedBox(
                            height: getheight(context, 15),
                          ),
                          Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(
                                width: getwidth(context, 5),
                              ),
                              Expanded(
                                child: Text(
                                  BlocProvider.of<CanteenCubit>(context)
                                      .state
                                      .currentuser
                                      .email,
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 15),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getheight(context, 8),
                          ),
                          SizedBox(height: getheight(context, 8)),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: getwidth(context, 5),
                              ),
                              Text(
                                BlocProvider.of<CanteenCubit>(context)
                                    .state
                                    .currentuser
                                    .phone,
                                style: TextStyle(
                                    fontSize: textSize.getadaptiveTextSize(
                                        context, 15),
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: getheight(context, 16)),
                          Row(
                            children: [
                              Icon(Icons.school),
                              SizedBox(
                                width: getwidth(context, 5),
                              ),
                              Expanded(
                                child: Text(
                                  "College: ${BlocProvider.of<CanteenCubit>(context).state.currentuser.College}",
                                  style: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 15),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getheight(context, 22),
                    ),
                    info_containers("Previous Orders", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviousOrders()));
                    }),
                    info_containers("About Us", () {}),
                    info_containers("Report Bug", () {
                      // String form_link =
                      //     "https://docs.google.com/forms/d/e/1FAIpQLSdXMHY8ThkaPg0009EHGeR1NrCdfoNLUxyRGFogmGwgbSUp7Q/viewform?usp=send_form";
                      // launchUrl(Uri.parse(form_link));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Issue_Collector()));
                    }),
                    info_containers("Logout", () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  padding:
                                      EdgeInsets.all(getwidth(context, 10)),
                                  // height: getheight(context, 180),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Alert!",
                                        style: TextStyle(
                                            color: orange_color,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                textSize.getadaptiveTextSize(
                                                    context, 22)),
                                      ),
                                      SizedBox(
                                        height: getheight(context, 22),
                                      ),
                                      Center(
                                        child: Text(
                                          "Are you sure you want to log out the app!",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  textSize.getadaptiveTextSize(
                                                      context, 18)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: getheight(context, 22),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          FirebaseAuth.instance.signOut();
                                          canteen = "Select College";
                                          canteen_bool = false;
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()));
                                        },
                                        child: Container(
                                          height: getheight(context, 40),
                                          width: getwidth(context, 130),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: orange_color),
                                          child: Center(
                                            child: Text(
                                              "Log out",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: textSize
                                                      .getadaptiveTextSize(
                                                          context, 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget info_containers(String function_name, Function functoin_work) {
    return GestureDetector(
      onTap: () {
        functoin_work();
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: getwidth(context, 21)),
          height: getheight(context, 60),
          width: getwidth(context, 315),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SizedBox(
                width: getwidth(context, 22),
              ),
              Text(
                function_name,
                style: TextStyle(
                    fontSize: textSize.getadaptiveTextSize(context, 18),
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: textSize.getadaptiveTextSize(context, 18),
              ),
              SizedBox(
                width: getwidth(context, 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
