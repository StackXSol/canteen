import 'package:canteen/screens/homepage.dart';
import 'package:canteen/screens/order_details.dart';
import 'package:canteen/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:canteen/widgets.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _index = 0;
  final List<Widget> screens = [HomePage(), OrderDetails(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
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
          selectedItemColor: Color(0xFFFA4A0C),
          iconSize: 50,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          currentIndex: _index,
        ),
      ),
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.2),
      //           offset: Offset(0, 0.2),
      //           blurRadius: 6,
      //         ),
      //       ],
      //       borderRadius: BorderRadius.circular(50),
      //       gradient:
      //           LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)])),
      //   child: FloatingActionButton(
      //     child: Icon(Icons.search),
      //     elevation: 0,
      //     backgroundColor: Colors.transparent,
      //     onPressed: () {},
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
