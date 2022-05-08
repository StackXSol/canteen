import 'package:canteen/widgets.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF5F5F8),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getheight(context, 60)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getwidth(context, 26)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: getheight(context, 24),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "My Profile",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  Spacer()
                ],
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
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("Edit Details"),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextField(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                  hintText: "Enter name",
                                                  hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey
                                                          .withOpacity(0.5)))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextField(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                  hintText: "Phone number",
                                                  hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey
                                                          .withOpacity(0.5)))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            height: getheight(context, 100),
                                            child: TextField(
                                                expands: true,
                                                maxLines: null,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                decoration: InputDecoration(
                                                    hintText: "Address",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.5)))),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        GestureDetector(
                                          onTap: () {
                                            ///////////// Edit changes ////////////
                                          },
                                          child: Container(
                                            height: getheight(context, 50),
                                            width: getwidth(context, 100),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: orange_color),
                                            child: Center(
                                              child: Text(
                                                "Done",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
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
            info_containers("Previous Orders", () {}),
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
