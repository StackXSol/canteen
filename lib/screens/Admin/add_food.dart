import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  late String _foodname;
  late String _price;
  late String _url;
  late final XFile? photo;
  final ImagePicker _picker = ImagePicker();
  String dropdownValue = 'BreakFast';
  var items = [
    'BreakFast',
    'Lunch',
    'Dinner',
    "Snacks",
    'Bakery',
    'Bevrages',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(height: getheight(context, 65)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 22)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Food",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 13,
                  ),
                  Text("Canteen Address"),
                ],
              ),
            ],
          )),
      SizedBox(
        height: getheight(context, 32),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: getwidth(context, 22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Food Name", style: TextStyle(color: Colors.black)),
            TextField(
              onChanged: (value) {
                setState(() {
                  _foodname = value;
                });
              },
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Food Name",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: getheight(context, 30),
            ),
            Text("Price", style: TextStyle(color: Colors.black)),
            TextField(
              onChanged: (value) {
                setState(() {
                  _price = value;
                });
              },
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Price",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: getheight(context, 30),
            ),
            Text("Category", style: TextStyle(color: Colors.black)),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              underline: Container(
                height: 0.3,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
            ),
            SizedBox(height: getheight(context, 36)),
            Text("Upload photo", style: TextStyle(color: Colors.black)),
            SizedBox(
              height: getheight(context, 20),
            ),
            GestureDetector(
              onTap: () async {
                photo = await _picker.pickImage(source: ImageSource.gallery);
              },
              child: Container(
                height: getheight(context, 42),
                width: getwidth(context, 152),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: orange_color),
                child: Center(
                    child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                )),
              ),
            ),
          ],
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () async {
          var uploadTask = FirebaseStorage.instance
              .ref(FirebaseAuth.instance.currentUser!.uid)
              .child(dropdownValue)
              .child(_foodname)
              .putFile(File(photo!.path));

          _url = await (await uploadTask).ref.getDownloadURL();

          print(_url);

          FirebaseFirestore.instance
              .collection("Canteens")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Menu")
              .doc(dropdownValue)
              .collection("Items")
              .doc(DateTime.now().toString())
              .set({
            "Name": _foodname,
            "Status": true,
            "Photo": _url,
            "Price": int.parse(_price)
          }, SetOptions(merge: true));
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Food Added!");
        },
        child: Container(
          height: getheight(context, 51),
          width: getwidth(context, 257),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: orange_color),
          child: Center(
            child: Text(
              "Save",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
        ),
      ),
      SizedBox(
        height: getheight(context, 34),
      )
    ]));
  }
}
