import 'package:canteen/backend_data.dart';
import 'package:canteen/main.dart';
import 'package:canteen/screens/Orders/pending_orders.dart';
import 'package:canteen/screens/homepage.dart';
import 'package:canteen/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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
  void initState() {
    setAppData();
    super.initState();
  }

  Future<void> setAppData() async {
    var key1 =
        await FirebaseFirestore.instance.collection("AppData").doc("Fee").get();

    var key2 = await FirebaseFirestore.instance
        .collection("AppData")
        .doc("Razorpay_Keys")
        .get();

    app_data = appData(
      fee: (key1.data() as dynamic)["charge"],
      key: (key2.data() as dynamic)["Live"],
    );
  }

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
                icon: Icon(Icons.home, size: getheight(context, 30)),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded,
                    size: getheight(context, 30)),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded,
                    size: getheight(context, 30)),
                label: ""),
          ],
          selectedItemColor: orange_color,
          iconSize: getheight(context, 50),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          currentIndex: _index,
        ),
      ),
    );
  }
}
