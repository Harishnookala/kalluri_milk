import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

import '../models/products.dart';
import 'editProducts.dart';

class shownProducts extends StatefulWidget {
  String?phonenumber;
  shownProducts({this.phonenumber});
  @override
  ShownProductsState createState() => ShownProductsState(phonenumber:this.phonenumber);
}

class ShownProductsState extends State<shownProducts> {
  String?phonenumber;
  ShownProductsState({this.phonenumber});
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
  var document_id;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.3),
      child: StreamBuilder<QuerySnapshot>(
          stream: collection,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot<Object?>? userData = snapshot.data;
              List categories = authentication.get_categories(userData);

              Iterable products = categories.reversed;
              categories = products.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 3.6,left: 13.3,top: 10.5),
                          child: Text(
                            category,
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Poppins-Light",
                                color: Color(0xff339245)),
                          ),
                        ),
                        build_sub_categories(userData, category),
                        Container(
                          margin: EdgeInsets.only(left: 12.3,right: 12.3),
                          child: Divider(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }



  build_sub_categories(QuerySnapshot<Object?>? userData, String category) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: userData!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot product = userData.docs[index];
          var id = product.id;
          String sub_categories = product.get("category");
          if (category == sub_categories) {
            var units = category == "Milk" ? "Ml" : "Gms";
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.4,
                    child: Card(
                      elevation: 2.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 3.5,top: 12.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GridView.count(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    children: [
                                      build_image(product),
                                      Container(
                                        margin: EdgeInsets.only(top: 12.3),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              build_data(product, units),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: build_buttons(userData,id)
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6.3),
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }

  build_image(DocumentSnapshot<Object?> product) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            CachedNetworkImage(
                imageUrl: product.get("image"),
                width: 100,
              ),
        ],
      ),
    );
  }

  build_data(DocumentSnapshot<Object?> product, String units) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

         Container(
            child: Text(
              "Kalluri".toUpperCase(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: "Poppins-Light",
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            margin: EdgeInsets.only(bottom: 3.3),
          ),

        Container(
          child: Text(
            product.get("productName"),
              style: TextStyle(fontSize:17,fontFamily: "Poppins-Medium")
          ),
          margin: EdgeInsets.only(bottom: 5.3),
        ),
        Container(
          margin: EdgeInsets.only(top: 3.6, bottom: 6.3),
          child:
              Text(product.get("quantity").toString() + " " + units + " Pouch"),
        ),
        Container(
            margin: EdgeInsets.only(top: 2.6, bottom: 8.3),
            child: Text("₹  " + product.get("price").toString(),style: TextStyle(fontSize:18,fontFamily: "Poppins-Medium"),)),
      ],
    );
  }

  build_buttons(QuerySnapshot<Object?> userData, String id) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(right: 7.3),
              child: TextButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(80, 40)),
                    backgroundColor: MaterialStateProperty.all(Color(0xcc167e43)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),

                ))),
                onPressed: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (BuildContext
                          context) =>
                              editProducts(id:id)));
                },
                child: Text("Edit",style: TextStyle(color: Colors.white,fontFamily:"Poppins-Medium",fontSize: 18),),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              child: TextButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(80, 40)),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),

                        ))), onPressed: () {
                FirebaseFirestore.instance
                    .collection("Admin")
                    .doc("Products")
                    .collection("Product_details")
                    .doc(id).delete();
                           },
                 child: Container(
                   margin: EdgeInsets.only(left: 4.3,right: 4.3),

                  child: Text("Delete",style: TextStyle(color: Colors.white,fontFamily:"Poppins-Medium",fontSize: 18),)),),
            ),
          ),
        ],
      ),
    );
  }
}
