import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../cubit/canteen_cubit.dart';
import '../main.dart';

class py_pg extends StatefulWidget {
  py_pg({required this.price});
  int price;
  @override
  _py_pgState createState() => _py_pgState();
}

class _py_pgState extends State<py_pg> {
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    oC();
    super.initState();
  }

  void oC() async {
    var options = {
      'key': app_data.key,
      'amount': widget.price * 100,
      'name': 'InIt',
      'email': FirebaseAuth.instance.currentUser!.email,
      'phone': BlocProvider.of<CanteenCubit>(context).state.currentuser.phone,
      'description': 'Init Payment',
      'prefill': {'contact': 'Enter Mobile'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    BlocProvider.of<CanteenCubit>(context).set_paystatus(context, true);
    _showtoastsuc();
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pop(context);
    _showtoast();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Page")),
      body: Column(),
    );
  }
}

Razorpay _razorpay = Razorpay();
String em = '';

final _showtoast = () => Fluttertoast.showToast(
    msg: "payment failed!",
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black);

final _showtoastlogin = () => Fluttertoast.showToast(
    msg: "Login Please",
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black);

final _showtoastsuc = () => Fluttertoast.showToast(
    msg: "Payment Successful!",
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black);
