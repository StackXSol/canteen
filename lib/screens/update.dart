import 'package:flutter/material.dart';
import 'package:init/widgets.dart';

import '../main.dart';

class Update extends StatelessWidget {
  const Update({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: getheight(context, 150),
          ),
          Image(
            image: AssetImage("images/logo.png"),
            height: getheight(context, 200),
            width: getheight(context, 200),
          ),
          SizedBox(
            height: getheight(context, 50),
          ),
          Center(
            child: Text(
              "Init needs an update!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: getheight(context, 15),
          ),
          Text("To use this app, download the latest version."),
          SizedBox(
            height: getheight(context, 25),
          ),
          GestureDetector(
            onTap: () {
              //////// update the application
            },
            child: Container(
              height: getheight(context, 40),
              width: getwidth(context, 130),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: orange_color),
              child: Center(
                child: Text(
                  "Update Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: textSize.getadaptiveTextSize(context, 17)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
