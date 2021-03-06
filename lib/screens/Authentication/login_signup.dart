import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:init/Policies/privacy.dart';
import 'package:init/Policies/terms.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../cubit/canteen_cubit.dart';
import '../../main.dart';
import '../../smtp.dart';
import '../../widgets.dart';
import '../Admin/admin_login.dart';
import '../Admin/admin_navbar.dart';
import '../email_verify_screen.dart';
import '../navbar.dart';
import 'forgotpassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final auth = FirebaseAuth.instance;
  late String _email = "";
  late String _pass = "";
  late String fullname;
  late String phone;
  final _gkey = GlobalKey<FormState>();
  String rollno = "1234";
  bool showSpinner = false;

  List<String> collegelist = [];

  late TabController _tabController;
  String dropdownValue = "Select College";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetch_colleges();
  }

  Future<void> fetch_colleges() async {
    collegelist = ["Select College"];

    var key = await FirebaseFirestore.instance
        .collection("CollegeList")
        .doc("Colleges")
        .get();

    for (var i in (key.data() as dynamic)["CollegeList"]) {
      collegelist.add(i.toString());
    }

    setState(() {});
  }

  @override
  bool _isObscure = true;
  bool check = false;

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      opacity: 0.2,
      progressIndicator: CircularProgressIndicator(
        color: orange_color,
      ),
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.black),
            backgroundColor: Color(0xffF5F5F8),
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
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: textSize.getadaptiveTextSize(context, 18),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign-up",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: textSize.getadaptiveTextSize(context, 18),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      top: getheight(context, 60),
                      left: getwidth(context, 30),
                      right: getwidth(context, 30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email address",
                          style: TextStyle(color: Colors.black)),
                      TextField(
                          onChanged: (value) {
                            setState(() {
                              _email = value.replaceAll(" ", "");
                            });
                          },
                          style: TextStyle(
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 17),
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Email",
                              hintStyle: TextStyle(
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 16),
                                  color: Colors.grey.withOpacity(0.5)))),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: getheight(context, 40),
                      ),
                      Text("Password", style: TextStyle(color: Colors.black)),
                      TextField(
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              _pass = value;
                            });
                          },
                          obscureText: _isObscure,
                          style: TextStyle(
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 17),
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: Colors.grey,
                                  )),
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              hintStyle: TextStyle(
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 16),
                                  color: Colors.grey.withOpacity(0.5)))),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      SizedBox(height: getheight(context, 30)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()),
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: orange_color,
                              fontSize:
                                  textSize.getadaptiveTextSize(context, 17),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      // SizedBox(
                      //   height: getheight(context, 40),
                      // ),
                      // SizedBox(
                      //   height: getheight(context, 200),
                      // ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            showSpinner = true;
                            print("spinner true");
                          });
                          try {
                            await auth
                                .signInWithEmailAndPassword(
                                    email: _email, password: _pass)
                                .then((value) async {
                              print("signin successful");
                              User? user = FirebaseAuth.instance.currentUser;

                              var key = await FirebaseFirestore.instance
                                  .collection("Users")
                                  .get();

                              bool _user = false;

                              for (var element in key.docs) {
                                if (element.id == user!.uid) {
                                  _user = await true;
                                  break;
                                }
                              }

                              if (_user) {
                                var key = await FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(user!.uid)
                                    .get();

                                BlocProvider.of<CanteenCubit>(context)
                                    .get_user_data(user.uid, context);

                                if ((key.data() as dynamic)["Verified"]) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Navbar(),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EmailverificationScreen(),
                                    ),
                                  );
                                }
                              } else {
                                {
                                  BlocProvider.of<CanteenCubit>(context)
                                      .getCanteenUserData(user!.uid, context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminNavbar(),
                                    ),
                                  );
                                }
                              }
                            });
                          } on FirebaseException catch (e) {
                            showSpinner = false;
                            Fluttertoast.showToast(msg: e.message.toString());
                            print(e.message.toString());
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
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize.getadaptiveTextSize(
                                      context, 17)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getheight(context, 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminLogin()),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Join Us",
                            style: TextStyle(
                                color: orange_color,
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 17),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getheight(context, 25),
                      ),
                    ],
                  )),
              Container(
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
                          //////////////// full name
                          Text("Full Name",
                              style: TextStyle(color: Colors.black)),
                          TextFormField(
                              validator: (value) {
                                if (value.toString().length <= 3 ||
                                    value.toString().length > 18) {
                                  return "Enter name of valid length!";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  fullname = value;
                                });
                              },
                              style: TextStyle(
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 17),
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16),
                                      color: Colors.grey.withOpacity(0.5)))),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: getheight(context, 15),
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
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 17),
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16),
                                      color: Colors.grey.withOpacity(0.5)))),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: getheight(context, 10),
                          ),
                          ////////////////// phone number

                          Row(
                            children: [
                              Text(
                                "????????",
                                style: TextStyle(
                                    fontSize: textSize.getadaptiveTextSize(
                                        context, 20)),
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
                                        fontSize: textSize.getadaptiveTextSize(
                                            context, 17),
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone number",
                                        hintStyle: TextStyle(
                                            fontSize:
                                                textSize.getadaptiveTextSize(
                                                    context, 16),
                                            color:
                                                Colors.grey.withOpacity(0.5)))),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            menuMaxHeight: 260,
                            isExpanded: true,
                            value: dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            underline: Container(
                              height: 0.5,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: collegelist
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: getheight(context, 15)),

                          ///// /////////roll number
                          Text("Roll Number",
                              style: TextStyle(color: Colors.black)),
                          TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                rollno = value;
                              },
                              style: TextStyle(
                                  fontSize:
                                      textSize.getadaptiveTextSize(context, 17),
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Roll number (Optional)",
                                  hintStyle: TextStyle(
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 16),
                                      color: Colors.grey.withOpacity(0.5)))),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(height: getheight(context, 15)),

                          ///////////////// password
                          Text("Password",
                              style: TextStyle(color: Colors.black)),
                          TextFormField(
                            cursorColor: Colors.black,
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
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 17),
                                fontWeight: FontWeight.bold),
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
                                fontSize:
                                    textSize.getadaptiveTextSize(context, 16),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: getheight(context, 25),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  activeColor: orange_color,
                                  value: check,
                                  onChanged: (val) {
                                    setState(() {
                                      check = val!;
                                    });
                                  }),
                              Container(
                                width: getwidth(context, 270),
                                child: Wrap(
                                  children: [
                                    Text(
                                      'I agree to the ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Terms()));
                                      },
                                      child: Text(
                                        'Terms & conditions ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: orange_color,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      'and ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Privacy()));
                                      },
                                      child: Text(
                                        'Privacy Policy ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: orange_color,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: getheight(context, 25)),
                          // Spacer(),
                          InkWell(
                            onTap: () async {
                              if (_gkey.currentState!.validate() &&
                                  dropdownValue != "Select College" &&
                                  check == true) {
                                setState(() {
                                  showSpinner = true;
                                });
                                Fluttertoast.showToast(msg: "Registering...");
                                try {
                                  await auth
                                      .createUserWithEmailAndPassword(
                                          email: _email, password: _pass)
                                      .then((value) async {
                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    final db = FirebaseFirestore.instance;
                                    await db
                                        .collection("Users")
                                        .doc(user!.uid)
                                        .set({
                                      "Fullname": fullname,
                                      "email": _email,
                                      "phone": phone,
                                      "uid": user.uid,
                                      "Rollno": rollno,
                                      "College": dropdownValue,
                                      "Verified": false
                                    }, SetOptions(merge: true));

                                    BlocProvider.of<CanteenCubit>(context)
                                        .get_user_data(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            BlocProvider.of<CanteenCubit>(
                                                    context)
                                                .state
                                                .cart_items);

                                    send_Register_email(_email);

                                    await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EmailverificationScreen(),
                                      ),
                                    ).then((value) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    });
                                  });
                                } on FirebaseException catch (e) {
                                  print(e);
                                  await Fluttertoast.showToast(
                                      msg: e.message.toString());
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              } else if (dropdownValue == "Select College") {
                                setState(() {
                                  showSpinner = false;
                                  Fluttertoast.showToast(
                                      msg: "Please select a college!");
                                });
                              } else if (check == false) {
                                setState(() {
                                  showSpinner = false;
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please accept terms and privacy policy!");
                                });
                              }
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
                                      fontSize: textSize.getadaptiveTextSize(
                                          context, 17)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getheight(context, 20),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // Future registration() async {}
}
