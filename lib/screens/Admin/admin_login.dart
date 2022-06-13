import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/screens/Admin/admin_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Authentication/forgotpassword.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> with TickerProviderStateMixin {
  final auth = FirebaseAuth.instance;
  late String _email;
  late String _canteenName;
  late String _pass;
  late int _code;
  late String phone;
  final _gkey = GlobalKey<FormState>();
  bool showSpinner = false;
  late TabController _tabController;
  String _accescode = "";
  var items = [
    'Select College',
  ];

  @override
  void initState() {
    super.initState();
    get_access_code();
    fetch_colleges();
    //change to 2
    _tabController = TabController(length: 1, vsync: this);
  }

  Future<void> get_access_code() async {
    dynamic key = await FirebaseFirestore.instance
        .collection("AppData")
        .doc("Access_Code")
        .get();
    _accescode = key.data()["code"].toString();
  }

  Future<void> fetch_colleges() async {
    items = ["Select College"];

    var key = await FirebaseFirestore.instance
        .collection("CollegeList")
        .doc("Colleges")
        .get();

    for (var i in (key.data() as dynamic)["CollegeList"]) {
      items.add(i.toString());
    }

    setState(() {});
  }

  String dropdownValue = 'Select College';

  @override
  bool _isObscure = true;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: getwidth(context, 75), top: 5),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 5.0, color: orange_color),
              insets: EdgeInsets.symmetric(horizontal: 35.0),
            ),
            labelPadding: EdgeInsets.all(15),
            controller: _tabController,
            tabs: <Widget>[
              // Text(
              //   "Login",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold),
              // ),
              Text(
                "Sign-up",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // SingleChildScrollView(
            //   child: Container(
            //       padding: EdgeInsets.only(
            //           top: getheight(context, 60),
            //           left: getwidth(context, 30),
            //           right: getwidth(context, 30)),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text("Email address",
            //               style: TextStyle(color: Colors.black)),
            //           TextField(
            //               onChanged: (value) {
            //                 setState(() {
            //                   _email = value.replaceAll(" ", "");
            //                 });
            //               },
            //               style: TextStyle(
            //                   fontSize: 17, fontWeight: FontWeight.bold),
            //               decoration: InputDecoration(
            //                   border: InputBorder.none,
            //                   hintText: "Enter Email",
            //                   hintStyle: TextStyle(
            //                       fontSize: 16,
            //                       color: Colors.grey.withOpacity(0.5)))),
            //           Divider(
            //             height: 2,
            //             color: Colors.black,
            //           ),
            //           SizedBox(
            //             height: getheight(context, 40),
            //           ),
            //           Text("Password", style: TextStyle(color: Colors.black)),
            //           TextField(
            //               onChanged: (value) {
            //                 setState(() {
            //                   _pass = value;
            //                 });
            //               },
            //               obscureText: _isObscure,
            //               style: TextStyle(
            //                   fontSize: 17, fontWeight: FontWeight.bold),
            //               decoration: InputDecoration(
            //                   suffixIcon: IconButton(
            //                       onPressed: () {
            //                         setState(() {
            //                           _isObscure = !_isObscure;
            //                         });
            //                       },
            //                       icon: Icon(
            //                         Icons.remove_red_eye,
            //                         color: Colors.grey,
            //                       )),
            //                   border: InputBorder.none,
            //                   hintText: "Enter Password",
            //                   hintStyle: TextStyle(
            //                       fontSize: 16,
            //                       color: Colors.grey.withOpacity(0.5)))),
            //           Divider(
            //             height: 2,
            //             color: Colors.black,
            //           ),
            //           SizedBox(height: getheight(context, 30)),
            //           GestureDetector(
            //             onTap: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ResetPassword()),
            //               );
            //               //////// reset passeord
            //             },
            //             child: Text(
            //               "Forgot password?",
            //               style: TextStyle(
            //                   color: orange_color,
            //                   fontSize: 17,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //           ),
            //           SizedBox(
            //             height: getheight(context, 260),
            //           ),
            //           ////////////////////// login
            //           GestureDetector(
            //             onTap: () async {
            //               setState(() {
            //                 showSpinner = true;
            //                 print("spinner true");
            //               });
            //               try {
            //                 await FirebaseAuth.instance
            //                     .signInWithEmailAndPassword(
            //                         email: _email, password: _pass);
            //                 BlocProvider.of<CanteenCubit>(context)
            //                     .getCanteenUserData(
            //                         FirebaseAuth.instance.currentUser!.uid,
            //                         context);
            //                 Navigator.pushReplacement(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => AdminNavbar()));
            //               } on FirebaseException catch (e) {
            //                 Fluttertoast.showToast(msg: e.message.toString());
            //               }
            //               setState(() {
            //                 showSpinner = false;
            //                 print("spinner false");
            //               });
            //             },
            //             child: Container(
            //               height: getheight(context, 70),
            //               width: getwidth(context, 310),
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(30),
            //                   color: orange_color),
            //               child: Center(
            //                 child: Text(
            //                   "Login",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 17),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: getheight(context, 25),
            //           ),
            //         ],
            //       )),
            // ),
            Container(
                height: getheight(context, getheight(context, 612)),
                padding: EdgeInsets.only(
                    top: getheight(context, 30),
                    left: getwidth(context, 30),
                    right: getwidth(context, 30)),
                child: Form(
                  key: _gkey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        //////////////// full name
                        Text("Access Code",
                            style: TextStyle(color: Colors.black)),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.toString() != _accescode) {
                                return "Enter valid code!";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _code = int.parse(value);
                              });
                            },
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Code",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.withOpacity(0.5)))),
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: getheight(context, 20),
                        ),

                        /////////// canteen name
                        Text("Canteen name",
                            style: TextStyle(color: Colors.black)),
                        TextFormField(
                            validator: (value) {
                              if (value.toString().length < 8) {
                                return "Enter valid Name!";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _canteenName = value;
                              });
                            },
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Canteen name",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.withOpacity(0.5)))),
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: getheight(context, 20),
                        ),

                        ////////////// email address for signup
                        Text("Email address",
                            style: TextStyle(color: Colors.black)),
                        TextFormField(
                            validator: (value) {
                              if (!(value!.contains("@"))) {
                                return "Enter valid Email!";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value.replaceAll(" ", "");
                              });
                            },
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Email",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.withOpacity(0.5)))),
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: getheight(context, 20),
                        ),
                        ////////////////// phone number

                        Row(
                          children: [
                            Text(
                              "🇮🇳",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              " +91",
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: getwidth(context, 200),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value.toString().length != 10) {
                                      return "Enter valid Number!";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone number",
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Colors.grey.withOpacity(0.5)))),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        /////////////// college
                        Text("College", style: TextStyle(color: Colors.black)),

                        DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          underline: Container(
                            height: 0.3,
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: items.map((String items) {
                            return DropdownMenuItem(
                                value: items, child: Text(items));
                          }).toList(),
                        ),

                        SizedBox(height: 20),

                        ///////////////// password
                        Text("Set Password",
                            style: TextStyle(color: Colors.black)),
                        TextFormField(
                          validator: (value) {
                            if (value.toString().length < 6) {
                              return "Password must be atleast 6 character long!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _pass = value;
                            });
                          },
                          obscureText: _isObscure,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                )),
                            border: InputBorder.none,
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        SizedBox(height: getheight(context, 15)),

                        SizedBox(height: getheight(context, 20)),

                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              showSpinner = true;
                              print("spinner true");
                            });
                            try {
                              if (_gkey.currentState!.validate()) {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _email, password: _pass);

                                FirebaseFirestore.instance
                                    .collection("Canteens")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({
                                  "College": dropdownValue,
                                  "phone": phone,
                                  "Name": _canteenName,
                                  "email": _email,
                                  "Total_Revenue": 0,
                                }, SetOptions(merge: true));

                                List<String> _cat = [
                                  'BreakFast',
                                  'Lunch',
                                  'Dinner',
                                  'Snacks',
                                  'Bakery',
                                  'Bevrages'
                                ];

                                for (var i in _cat) {
                                  FirebaseFirestore.instance
                                      .collection("Canteens")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("Menu")
                                      .doc(i)
                                      .set({}, SetOptions(merge: true));
                                }

                                FirebaseFirestore.instance
                                    .collection("Canteens")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("Revenue");

                                FirebaseFirestore.instance
                                    .collection("Canteens")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("Menu")
                                    .doc();

                                BlocProvider.of<CanteenCubit>(context)
                                    .getCanteenUserData(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        context);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminNavbar()),
                                ).then((value) {
                                  BlocProvider.of<CanteenCubit>(context)
                                      .getCanteenUserData(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          context);
                                });
                              }
                            } catch (e) {
                              setState(() {
                                showSpinner = true;
                                print("spinner true");
                              });
                            }

                            setState(() {
                              showSpinner = false;
                              print("spinner false");
                            });
                          },
                          child: Container(
                            height: getheight(context, 70),
                            width: getwidth(context, 310),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: orange_color),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getheight(context, 25),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
