import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../cubit/canteen_cubit.dart';
import '../../widgets.dart';
import '../Admin/admin_navbar.dart';
import '../email_verify_screen.dart';
import '../navbar.dart';
import 'login_signup.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    check_admin();
    super.initState();
  }

  Future<void> check_admin() async {
    var key = await FirebaseFirestore.instance.collection("Canteens").get();
    bool admin = false;
    try {
      for (var i in key.docs) {
        if (i.id == FirebaseAuth.instance.currentUser!.uid) {
          BlocProvider.of<CanteenCubit>(context).getCanteenUserData(
              FirebaseAuth.instance.currentUser!.uid, context);

          Future.delayed(
              const Duration(seconds: 1),
              () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminNavbar()),
                  ));
          admin = true;
        }
      }
      !admin ? set_screen() : null;
    } catch (e) {
      set_screen();
    }
  }

  Future<void> set_screen() async {
    try {
      BlocProvider.of<CanteenCubit>(context)
          .get_user_data(FirebaseAuth.instance.currentUser!.uid, context);

      var key = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      print((key.data() as dynamic)["Verified"]);

      if ((key.data() as dynamic)["Verified"]) {
        Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Navbar()),
                ));
      } else {
        Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmailverificationScreen()),
                ));
      }
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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: getheight(context, 200),
          ),
          Image(
              height: getheight(context, 225),
              width: getheight(context, 225),
              image: AssetImage("images/logo.png")),
          SizedBox(
            height: getheight(context, 182),
          ),
          SpinKitFadingCircle(
            color: Colors.red,
            size: 50.0,
          ),
          SizedBox(
            height: getheight(context, 10),
          ),
          Center(
              child: Image(
                  width: getwidth(context, 247),
                  image: AssetImage("images/logo2.png")))
        ],
      ),
    );
  }
}
