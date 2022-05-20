import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:canteen/cubit/canteen_cubit.dart';
import 'package:canteen/screens/Admin/admin_navbar.dart';

import 'package:canteen/screens/Admin/scanned_details.dart';
import 'package:canteen/screens/Authentication/login_signup.dart';
import 'package:canteen/screens/navbar.dart';
import 'package:canteen/screens/profile.dart';
import 'package:canteen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  if (result != null)
                    Text(
                      'OID: ${result!.code}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )
                  else
                    const Text(
                      'Scan a code',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 8),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: Container(
                            height: 20,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: orange_color),
                            margin: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                "FlashLight",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 6),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 350.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: orange_color,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      // function on QR code which is scanned!
      var data = await result!.code!.replaceAll("[", "").replaceAll("]", "");
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

      if (!key.docs.first.id.isEmpty) {
        if ((key1.data() as dynamic)["College"] ==
            BlocProvider.of<CanteenCubit>(context)
                .state
                .currentCanteenUser
                .getter()[4]) {
          if (!keyd.data()["Status"]) {
            print(keyd.data()["DateTime"]);
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
          }
        } else {
          Fluttertoast.showToast(msg: "College not matching!");
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
