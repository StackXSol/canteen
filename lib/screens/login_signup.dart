import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late TabController _tabController;
  String dropdownValue = 'One';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  bool _isObscure = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 6.0, color: Color(0xFFFA4A0C)),
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
                  Text("Email address", style: TextStyle(color: Colors.grey)),
                  TextField(
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
                  Text("Password", style: TextStyle(color: Colors.grey)),
                  TextField(
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
                          color: Color(0xFFFA4A0C),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      //login
                    },
                    child: Container(
                      height: getheight(context, 70),
                      width: getwidth(context, 310),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFFA4A0C)),
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
                  Text("Full Name", style: TextStyle(color: Colors.grey)),
                  TextField(
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

                  ////////////// email address
                  Text("Email address", style: TextStyle(color: Colors.grey)),
                  TextField(
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
                  Text("College", style: TextStyle(color: Colors.grey)),
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
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 15),

                  ///// /////////roll number
                  Text("Roll Number", style: TextStyle(color: Colors.grey)),
                  TextField(
                      obscureText: _isObscure,
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
                  Text("Password", style: TextStyle(color: Colors.grey)),
                  TextField(
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
                  SizedBox(height: getheight(context, 15)),

                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      //login
                    },
                    child: Container(
                      height: getheight(context, 70),
                      width: getwidth(context, 310),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFFA4A0C)),
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
              )),
        ],
      ),
    );
  }
}
