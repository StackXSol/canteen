import 'package:canteen/screens/Admin/admin_homepage.dart';
import 'package:canteen/screens/Admin/revenue.dart';
import 'package:canteen/screens/homepage.dart';
import 'package:flutter/material.dart';

import '../../widgets.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(height: getheight(context, 60)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.keyboard_arrow_left)),
              ],
            ),
            SizedBox(
              height: getheight(context, 25),
            ),
            Text(
              "My Profile",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      SizedBox(
        height: getheight(context, getheight(context, 40)),
      ),
      _profileFunctions(
        title: "Revenue",
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Revenue()),
          );
        },
      ),
      SizedBox(
        height: getheight(context, 30),
      ),
      _profileFunctions(
        title: "Faq",
        ontap: () {
          ///////// faq ///////
        },
      ),
      SizedBox(
        height: getheight(context, 30),
      ),
      _profileFunctions(
        title: "Contact Us",
        ontap: () {
          ///////// contact us ///////
        },
      ),
      SizedBox(
        height: getheight(context, 30),
      ),
      _profileFunctions(
        title: "Sign out",
        ontap: () {
          ///////// sign out ///////
        },
      ),
    ]));
  }
}

class _profileFunctions extends StatelessWidget {
  _profileFunctions({required this.title, required this.ontap});
  String title;
  VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: getheight(context, 60),
        width: getwidth(context, 315),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 20)),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      ),
    );
  }
}
