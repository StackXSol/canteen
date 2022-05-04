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
      backgroundColor: Color(0xffE5E5E5),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getheight(context, 45)),
            Padding(
              padding: EdgeInsets.only(left: getwidth(context, 36)),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: getheight(context, 24),
              ),
            ),
            SizedBox(
              height: getheight(context, 32),
            ),
            Padding(
              padding: EdgeInsets.only(left: getwidth(context, 36)),
              child: const Text(
                "My Profile",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: getheight(context, 26),
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
                    child: const Text(
                      "edit",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffFA4A0C),
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
              margin: EdgeInsets.only(left: getwidth(context, 27)),
              height: getheight(context, 197),
              width: getwidth(context, 315),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffffffff),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: getwidth(context, 8)),
                    height: getheight(context, 100),
                    width: getwidth(context, 91),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getwidth(context, 7),
                        top: getheight(context, 26),
                        bottom: getheight(context, 29)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000)),
                        ),
                        Text(
                          "email123@gmail.com",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: getheight(context, 8),
                        ),
                        Container(
                          color: Colors.black,
                          height: getheight(context, 0.5),
                          width: getwidth(context, 165),
                        ),
                        SizedBox(height: getheight(context, 7)),
                        Text(
                          "91+ 9871228811",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: getheight(context, 8)),
                        Container(
                          color: Colors.black,
                          height: getheight(context, 0.5),
                          width: getwidth(context, 165),
                        ),
                        SizedBox(height: getheight(context, 7)),
                        Expanded(
                          child: Text(
                            "2C - 1707 Golflinks,Ghaziabad,UttarPradesh",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getheight(context, 21),
            ),
            info_containers("Orders", () {}),
            SizedBox(
              height: getheight(context, 21),
            ),
            info_containers("Faq", () {}),
            SizedBox(
              height: getheight(context, 21),
            ),
            info_containers("About Us", () {}),
            SizedBox(
              height: getheight(context, 21),
            ),
            info_containers("Help", () {})
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
      child: Container(
        margin: EdgeInsets.only(left: getwidth(context, 27)),
        height: getheight(context, 60),
        width: getwidth(context, 315),
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.only(
              left: getwidth(context, 23), right: getwidth(context, 67)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                function_name,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w800),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
