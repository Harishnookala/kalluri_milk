import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

import 'homeScreen.dart';

class newProducts extends StatefulWidget {
  @override
  newProductsState createState() => newProductsState();
}

class newProductsState extends State<newProducts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController productImage = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  Authentication authentication = Authentication();
  final newProduct_key = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  var image;
  List Category = ['Milk', 'Curd', 'Ghee', 'Paneer'];

  String? Selecteditem = "";

  File? imageFile;

  var url;

  String? imageurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbf5e5),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: Form(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.only(left: 20.3, right: 20.3),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Product Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins-Light"),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          build_product_name(),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Text(
                              "Product Category",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins-Light"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          build_category(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12.3),
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins-Light"),
                            ),
                          ),
                          build_price(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12.3),
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins-Light"),
                            ),
                          ),
                          //SizedBox(height: 8,),
                          build_Quantity(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12.3),
                            child: Text(
                              "Upload Image",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins-Light"),
                            ),
                          ),
                          build_Image(),
                          SizedBox(
                            height: 5,
                          ),
                          Save_button(),
                          SizedBox(
                            height: 10,
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  build_product_name() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (name) {
          if (name!.isEmpty) {
            return 'Please enter product name';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Enter Product Name",
            labelText: "Name",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: nameController,
      ),
    );
  }

  build_category() {
    return DropdownButtonFormField2(
      focusColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Select Category",
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
        ),
        filled: true,
        contentPadding: EdgeInsets.zero,
      ),
      hint: const Text(
        'Select Your Category',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
      ),
      iconSize: 20,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      items: Category.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Selecteditem = item;
            },
          )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select category.';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
      },
      onSaved: (value) {
        Selecteditem = value.toString();
        value = Selecteditem;
      },
    );
  }

  build_price() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (price) {
          if (price!.isEmpty) {
            return 'Please enter price';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Enter Price",
            labelText: "Price",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: priceController,
      ),
    );
  }

  build_Quantity() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (quantity) {
          if (quantity!.isEmpty) {
            return 'Please enter Quantity';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "How much Quantity",
            labelText: "Quantity",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: QuantityController,
      ),
    );
  }

  uploadImage() {
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(20, 20),
              primary: Colors.greenAccent,
              backgroundColor: Color(0xffc29b51)),
          onPressed: () {
            _getFromGallery();
          },
          child: Text(
            "Upload ",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  build_Image() {
    return Container(
      child: Column(
        children: [
          imageFile != null
              ? Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            left: 12.3,
                            right: 12.3,
                            top: 5.6,
                          ),
                          child: Center(
                            child: Image.file(
                              imageFile!,
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              imageFile = null;
                            });
                          },
                          child: Text(
                            "Remove",
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                )
              : Container(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Color(0xcc9fce4c),
                    )),
                    child: Container(
                        margin: EdgeInsets.only(right: 12.3),
                        child: uploadImage()),
                  ),
                )
        ],
      ),
    );
  }

  Save_button() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(140, 30)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
              side: BorderSide(color: Colors.green),
            ))),
        onPressed: () async {
          var image = authentication.moveToStorage(
              imageFile, Selecteditem, nameController.text);
          String? image_url = await image;

          Map<String, dynamic> data = {
            "Product_details": {
              Selecteditem:[{
                "Product Name": nameController.text,
                "Price": int.parse(priceController.text),
                "Quantity": int.parse(QuantityController.text),
                "Image": image_url,}
              ]
            },
          };
          await FirebaseFirestore
              .instance
              .collection('Admin').doc("Products").collection("Product_details").add(data);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)  => adminPannel()),
          );
        },
        child: Text(
          "Save",
          style: TextStyle(fontSize: 15, fontFamily: "Poppins-Medium"),
        ),
      ),
    );
  }
}
