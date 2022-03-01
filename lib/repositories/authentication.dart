import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kalluri_milk/models/products.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Authentication {
  CollectionReference get = FirebaseFirestore.instance.collection('Admin');

  String phone_authentication(String user_number, String otp_number) {
    String? phone_number = "7995289160";
    String? number = "123456";
    if (user_number == phone_number && otp_number == number) {
      return "admin";
    } else {
      return "user";
    }
  }

  Future<String?> moveToStorage(
      File? imageFile, String? selecteditem, String text) async {
    if (imageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child(selecteditem!)
          .child(text + " .jpeg");
      await ref.putFile(imageFile);
      var url = await ref.getDownloadURL();
      return url;
    }
  }

  Stream<QuerySnapshot> product_values()  {
    var products;
    var collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .snapshots();
    Stream<QuerySnapshot> snapshot = collection;
    snapshot.toList();
      products = snapshot.forEach((element) {
        var documents = element.docs.toList();
         for(int i = 0;i<documents.length;i++){
          var product_values = documents[i].data();

         }

     });
    return products;
  }
}
