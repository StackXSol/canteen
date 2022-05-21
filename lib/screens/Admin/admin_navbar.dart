import 'package:canteen/main.dart';
import 'package:canteen/screens/Admin/admin_homepage.dart';
import 'package:canteen/screens/Admin/admin_pending_orders.dart';
import 'package:canteen/screens/Admin/admin_profile.dart';
import 'package:canteen/screens/Admin/MonthlyOrders/orders_this_month.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';

class AdminNavbar extends StatefulWidget {
  const AdminNavbar({Key? key}) : super(key: key);

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  int _index = 0;
  final List<Widget> screens = [
    AdminHomepage(),
    AdminPendingOrders(),
    AdminProfile()
  ];

  @override
  void initState() {
    // verify_mail();
  }

  // void verify_mail() {
  //   FirebaseAuth.instance.sendSignInLinkToEmail(
  //       email: currentUser.email,
  //       actionCodeSettings: ActionCodeSettings(
  //           url: "https://google.com", handleCodeInApp: true));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: screens[_index]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (val) {
            setState(() {
              print(val);
              _index = val;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded, size: 30), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded, size: 30), label: ""),
          ],
          selectedItemColor: orange_color,
          iconSize: 50,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          currentIndex: _index,
        ),
      ),
    );
  }
}
