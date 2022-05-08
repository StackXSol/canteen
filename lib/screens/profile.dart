import 'package:canteen/widgets.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getheight(context, 60)),
            Padding(
              padding: EdgeInsets.only(left: getwidth(context, 26)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: getheight(context, 24),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: getwidth(context, 26)),
                      child: const Text(
                        "My Profile",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getheight(context, 42),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getwidth(context, 35), right: getwidth(context, 47)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Personal Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "edit",
                      style: TextStyle(
                        fontSize: 15,
                        color: orange_color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 11),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: getwidth(context, 27)),
              height: getheight(context, 197),
              width: getwidth(context, 315),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000)),
                  ),
                  SizedBox(
                    height: getheight(context, 12),
                  ),
                  Text(
                    "email123@gmail.com",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: getheight(context, 8),
                  ),
                  Container(
                    color: Colors.black,
                    height: getheight(context, 0.5),
                    width: getwidth(context, 165),
                  ),
                  SizedBox(height: getheight(context, 8)),
                  Text(
                    "91+ 9871228811",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: getheight(context, 8)),
                  Container(
                    color: Colors.black,
                    height: getheight(context, 0.5),
                    width: getwidth(context, 165),
                  ),
                  SizedBox(height: getheight(context, 8)),
                  Container(
                    width: getwidth(context, 285),
                    child: Text(
                      "2C - 1707 Golflinks,Ghaziabad,UttarPradesh",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            info_containers("Orders", () {}),
            info_containers("About Us", () {}),
            info_containers("Report Bug", () {}),
            info_containers("Logout", () {})
          ],
        ),
      ),
    );
  }

  Widget info_containers(String function_name, Function functoin_work) {
    return GestureDetector(
      onTap: () {
        functoin_work();
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: getwidth(context, 21)),
          height: getheight(context, 60),
          width: getwidth(context, 315),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SizedBox(
                width: getwidth(context, 22),
              ),
              Text(
                function_name,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              SizedBox(
                width: getwidth(context, 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
