import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:init/screens/Authentication/login_signup.dart';

import '../cubit/canteen_cubit.dart';
import '../smtp.dart';
import '../widgets.dart';
import 'navbar.dart';

class EmailverificationScreen extends StatefulWidget {
  EmailverificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailverificationScreen> createState() =>
      _EmailverificationScreenState();
}

class _EmailverificationScreenState extends State<EmailverificationScreen> {
  bool isemailverified = false;
  bool wait = true;
  int start = 30;
  Timer? timer;
  int _sentOtp = 0;
  int _otp = 0;

  @override
  void initState() {
    super.initState();
    starttimer();
    send_otp();
  }

  void send_otp() {
    Fluttertoast.showToast(msg: "Sending OTP!");
    String email = FirebaseAuth.instance.currentUser!.email!;
    Fluttertoast.showToast(msg: email);
    _sentOtp = Random().nextInt(1000000) +
        Random().nextInt(10000) +
        Random().nextInt(100);
    verify_email(email, _sentOtp);
  }

  void starttimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (_timer) {
      if (start == 0) {
        setState(() {
          wait = false;
          _timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("images/otp.png"),
              height: getheight(context, 340),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value.toString().length < 4) {
                      return "Enter valid Name!";
                    }
                    return null;
                  },
                  onChanged: ((value) {
                    _otp = int.parse(value);
                  }),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: "Enter OTP sent on email",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black))),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Haven't recieved email?\nSend again in ",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  TextSpan(
                      text: "00:$start ",
                      style: TextStyle(
                          color: orange_color, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "sec",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 8),
            ),
            Visibility(
                visible: !wait,
                child: InkWell(
                  onTap: () {
                    starttimer();
                    send_otp();
                    setState(() {
                      wait = true;
                      start = 30;
                    });
                  },
                  child: Text(
                    "Resend",
                    style: TextStyle(
                        fontSize: 18,
                        color: orange_color,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
              height: getheight(context, 26),
            ),
            GestureDetector(
              onTap: () {
                if (_otp == _sentOtp) {
                  Fluttertoast.showToast(msg: "email verified!");
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({"Verified": true});
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Navbar()));
                } else {
                  Fluttertoast.showToast(msg: "OTP not correct!");
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                child: Text(
                  "verify",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "Wrong email?",
                style: TextStyle(
                    color: orange_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
