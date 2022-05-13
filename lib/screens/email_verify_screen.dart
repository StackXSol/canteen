import 'dart:async';

import 'package:canteen/screens/homepage.dart';
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

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
      body: Container(
          alignment: Alignment.center,
          child: Text("email verification screen")),
    );
  }
}
