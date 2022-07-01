import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../main.dart';
import '../widgets.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getheight(context, 45)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getwidth(context, 20)),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.keyboard_arrow_left),
                    )),
                SizedBox(
                  width: getwidth(context, 85),
                ),
                Text("About Us",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textSize.getadaptiveTextSize(context, 18))),
              ],
            ),
          ),
          SizedBox(
            height: getheight(context, 10),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: getwidth(context, 30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We at Init wanted to help out everyone whose time was wasted by standing in long queues for the food order and getting delayed payments.\n",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "And from now, you no need to struggle in between the crowd to get your food. We brought the ordering system into your pockets. \n",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "We are here with a super app, where you can order the food just 3 clicks away.\n",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Using Init we can skip long waiting periods to get our food token and make the payments super fast!\n",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Step 1:- Select your Food.\n",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Step 2:- Add your favorite food to the cart.\n",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Step 3:- pay the amount through your preferred mode.\n",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Step 4:- Show the generated QR at the food takeaway counter from the orders section.\n",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Step 5:- That's it! You're Done.... Enjoy your favorite fooooood.\n",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "We know you. Your time is precious. We value your time.\n",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Do rate us on the play store & App store. Your feedback will be appreciated!\n",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    Center(
                      child: Text(
                        "Contact us at support@init.com\n",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
