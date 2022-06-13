import 'package:canteen/screens/Admin/scanned_details.dart';
import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../cubit/canteen_cubit.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Scanner'),
        backgroundColor: orange_color,
      ),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) async {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              var data = await code.replaceAll("[", "").replaceAll("]", "");
              List<String> datalist = await data.split(',');

              var key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(datalist[1].toString().trim())
                  .collection("Orders")
                  .where("OID", isEqualTo: int.parse(datalist[0]))
                  .get();
              var key1 = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(datalist[1].toString().trim())
                  .get();
              var keyd = await key.docs.first;
              debugPrint('Barcode found! $code');

              if (!key.docs.first.id.isEmpty) {
                if ((key1.data() as dynamic)["College"] ==
                    BlocProvider.of<CanteenCubit>(context)
                        .state
                        .currentCanteenUser
                        .getter()[4]) {
                  if (!keyd.data()["Status"]) {
                    //change here!
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QROrderDetails(
                          uid: datalist[1].trim(),
                          oid: int.parse(datalist[0]),
                          paystatus: false,
                          items: keyd.data()["Items"],
                          datetime: DateTime.parse(keyd.data()["DateTime"]),
                        ),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(msg: "Already Scanned!");
                    Navigator.pop(context);
                  }
                } else {
                  Fluttertoast.showToast(msg: "College not matching!");
                  Navigator.pop(context);
                }
              }
            }
          }),
    );
  }
}
