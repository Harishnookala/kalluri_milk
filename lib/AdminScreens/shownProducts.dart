import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

import '../models/products.dart';

class shownProducts extends StatefulWidget {
  @override
  ShownProductsState createState() => ShownProductsState();
}

class ShownProductsState extends State<shownProducts> {
  Authentication authentication = Authentication();
  @override
  initState() {
    super.initState();

  }
  var collection = FirebaseFirestore.instance
      .collection("Admin")
      .doc("Products")
      .collection("Product_details")
      .snapshots();
  @override
  Widget build(BuildContext context) {
       Products? products;
       return StreamBuilder<QuerySnapshot>(
         stream:collection,
         builder: (context, AsyncSnapshot<QuerySnapshot>userSnapshot) {
           if(userSnapshot.hasData){
             QuerySnapshot<Object?>?  userData = userSnapshot.data;
              var data = userData!.docs.toList();
               List<Widget>children = [];
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot userData =
                    userSnapshot.data!.docs[index];
                    var products = userData.get("Category");
                    
                    return new Column(
                    children: [
                         Text(products["category"])
                    ],
                  );
              });
           }
           return CircularProgressIndicator();
         },
       );
}

   get_data(List<QueryDocumentSnapshot<Object?>> data) {
       data.forEach((element) {
         print(element.data());
       });
   }

}
