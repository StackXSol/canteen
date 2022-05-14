import 'package:canteen/backend_data.dart';
import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/main.dart';

import 'package:canteen/screens/navbar.dart';
import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'login_signup.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    set_screen();
    super.initState();
  }

  Future<void> set_screen() async {
    try {
      dynamic key = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(key.data());
      BlocProvider.of<CanteenCubit>(context)
          .get_user_data(FirebaseAuth.instance.currentUser!.uid);

      Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Navbar()),
              ));
    } catch (e) {
      print(e);
      Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: AssetImage('images/Splashscreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: getheight(context, 320),
          left: getwidth(context, 113),
          child: Container(
            height: getheight(context, 200),
            width: getheight(context, 200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Food For everyone",
                  style: TextStyle(color: Colors.red),
                ),
                SpinKitFadingCircle(
                  color: Colors.red,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
