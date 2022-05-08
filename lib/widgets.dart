import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double getheight(context, value) {
  return MediaQuery.of(context).size.height * (value / 812);
}

double getwidth(context, value) {
  return MediaQuery.of(context).size.width * (value / 375);
}

Color orange_color = Color.fromARGB(255, 236, 122, 80);
