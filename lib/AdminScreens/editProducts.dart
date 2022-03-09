import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

import 'edit_data.dart';
import 'homeScreen.dart';

class editProducts extends StatefulWidget {
  String? id;
  editProducts({this.id});
  @override
  editProductsState createState() {
    return editProductsState(id: this.id);
  }
}

class editProductsState extends State<editProducts> {
  var collection;
  String? id;
  String? unSelectedImage;
  var unSelecteditem;
  List Category = ['Milk', 'Curd', 'Ghee', 'Paneer'];
  String Selecteditem = "";
  File? imageFile;
  var url;
  editProductsState({this.id});
  @override
  initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .doc(id)
        .get();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffbf5e5),
        body: FutureBuilder(
            future: collection,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                var product = snapshot.data;
                return editData(id:id,
                  name:product!.get("productName"),
                  category:product.get("category"),
                  price:product.get("price"),
                  quantity:product.get("quantity"),
                  image:product.get("image"),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }


  }

