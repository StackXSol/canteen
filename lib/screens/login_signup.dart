import 'package:canteen/backend_data.dart';
import 'package:canteen/screens/homepage.dart';
import 'package:canteen/screens/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late final BackendData userdata;
  final auth = FirebaseAuth.instance;
  late String _email;
  late String _pass;
  late String fullname;
  late String phone;
  late String rollno;

  late TabController _tabController;
  String dropdownValue = "Select College";
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  bool _isObscure = true;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
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
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
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
      body: TabBarView(
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
                  Text("Email address", style: TextStyle(color: Colors.black)),
                  TextField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                    height: getheight(context, 40),
                  ),
                  Text("Password", style: TextStyle(color: Colors.black)),
                  TextField(
                      onChanged: (value) {
                        setState(() {
                          _pass = value;
                        });
                      },
                      obscureText: _isObscure,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.5)))),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  SizedBox(height: getheight(context, 30)),
                  GestureDetector(
                    onTap: () {
                      //forgot password
                    },
                    child: Text(
                      "Forgot passcode?",
                      style: TextStyle(
                          color: orange_color,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      login();
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
                              fontSize: 17),
                        ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //////////////// full name
                  Text("Full Name", style: TextStyle(color: Colors.black)),
                  TextField(
                      onChanged: (value) {
                        setState(() {
                          fullname = value;
                        });
                      },
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.5)))),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: getheight(context, 15),
                  ),

                  ////////////// email address for signup
                  Text("Email address", style: TextStyle(color: Colors.black)),
                  TextField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                    height: getheight(context, 10),
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
                        child: TextField(
                            onChanged: (value) {
                              phone = value;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone number",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.withOpacity(0.5)))),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                      height: 0.5,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Select College', 'XYZ', 'Tree', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 15),

                  ///// /////////roll number
                  Text("Roll Number", style: TextStyle(color: Colors.black)),
                  TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        rollno = value;
                      },
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Roll number",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.5)))),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  SizedBox(height: getheight(context, 15)),

                  ///////////////// password
                  Text("Password", style: TextStyle(color: Colors.black)),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _pass = value;
                      });
                    },
                    obscureText: _isObscure,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(Icons.remove_red_eye)),
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

                  Spacer(),
                  GestureDetector(
                    /////////// sign up////////////////
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Navbar()),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        registration();
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
                  ),
                  SizedBox(
                    height: getheight(context, 25),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future registration() async {
    try {
      auth
          .createUserWithEmailAndPassword(email: _email, password: _pass)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        final db = FirebaseFirestore.instance;
        db.collection("Users").doc(user!.uid).set({
          "Fullname": fullname,
          "email": _email,
          "phone": phone,
          "uid": user.uid,
          "Rollno": rollno,
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future login() async {
    try {
      auth
          .signInWithEmailAndPassword(email: _email, password: _pass)
          .then((value) {
        print("signin successful");
        User? user = FirebaseAuth.instance.currentUser;
        var db = FirebaseFirestore.instance;

        var userdata = db.collection("Users").doc(user?.uid).get();

        print(userdata);

        // BackendData(
        //     full_name: "vaibhav",
        //     email: "email",
        //     phone: 45,
        //     uid: user.uid,
        //     Roll_no: 1313);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
