import 'package:canteen/screens/homepage.dart';
import 'package:canteen/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 6),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: AssetImage('images/Splashscreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: getheight(context, 320),
          left: getwidth(context, 113),
          child: Container(
            height: getheight(context, 200),
            width: getheight(context, 200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Food For everyone",
                  style: TextStyle(color: Colors.red),
                ),
                SpinKitFadingCircle(
                  color: Colors.red,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
