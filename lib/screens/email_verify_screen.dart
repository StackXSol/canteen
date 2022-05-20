import 'dart:async';
import 'dart:ffi';

import 'package:canteen/screens/homepage.dart';
import 'package:canteen/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();

    starttimer();

    isemailverified = FirebaseAuth.instance.currentUser!.emailVerified;

    timer = Timer.periodic(Duration(seconds: 2), (_) => checkemailverified());
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkemailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isemailverified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isemailverified) {
      timer?.cancel();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Haven't recieved email? Send again in ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(text: "00:$start ", style: TextStyle(color: orange_color)),
                  TextSpan(
                      text: "sec",
                      style: TextStyle(color: Colors.black)),
            ])),
            SizedBox(
              height: getheight(context, 30),
            ),
            wait
                ? Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade800,
                    ),
                    child: Text(
                      "Resend",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      FirebaseAuth.instance.currentUser!.sendEmailVerification;
                      starttimer();
                      setState(() {
                        wait = true;
                        start = 30;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: orange_color,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Resend",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
