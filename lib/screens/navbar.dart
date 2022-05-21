import 'package:canteen/main.dart';
import 'package:canteen/screens/Orders/pending_orders.dart';
import 'package:canteen/screens/homepage.dart';
import 'package:canteen/screens/order_details.dart';
import 'package:canteen/screens/profile.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _index = 0;
  final List<Widget> screens = [HomePage(), PendingOrders(), Profile()];

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
