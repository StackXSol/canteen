import 'package:canteen/backend_data.dart';
import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/screens/homepage.dart';
import 'package:canteen/widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/Authentication/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) => CanteenCubit(),
    child: MyApp(),
  ));
}

AdaptiveTextSize textSize = AdaptiveTextSize();
List<List> cart_list = [];
String canteenId = "";
appData app_data = appData(fee: 0, key: "");
bool carousel = false;
bool canteen_bool = false;
List images = [];
String canteen = "Select Canteen";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffF5F5F8),
        fontFamily: "Gilroy",
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      // home: EmailverificationScreen(),
      routes: {
        '/loadingscreen': (context) => const LoadingPage(),
      },
      initialRoute: '/loadingscreen',
    );
  }
}
