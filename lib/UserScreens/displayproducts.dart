import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';
import 'package:kalluri_milk/UserScreens/wallets.dart';
import 'package:get/get.dart';
class displayProducts extends StatefulWidget {
  List<DocumentSnapshot<Object?>?>? products;
  List? listofvalues;
  int? index;
  int? product_items;
  List<String>? product_name;
  displayProducts(
      {this.products, this.listofvalues, this.index, this.product_items,this.product_name});

  displayProductsState createState() {
    return displayProductsState(
      products: this.products,
      listofvalues: this.listofvalues,
      index: this.index,
      product_items: this.product_items,
      product_name:this.product_name,
    );
  }
}

class displayProductsState extends State<displayProducts> {
  List<DocumentSnapshot<Object?>?>? products;
  List? listofvalues;
  int? index;
  int? product_items;
  List? valueOfProducts;
  List<String>? product_name;
  List values =[];
  displayProductsState(
      {this.products, this.listofvalues, this.index, this.product_items,this.product_name});
  @override
  void initState() {
    if (product_items == null) {
      product_items = 0;
    }
    if (valueOfProducts == null) {
      valueOfProducts = [];
    }
    if(values ==null){
      values =[];
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.3, top: 14.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Kalluri",
                    ),
                  ),
                  Container(
                    child: Text(products![0]!.get("productName")),
                  ),
                  Container(
                    child:
                        Text(products![0]!.get("quantity").toString() + "Ml Pouch"),
                  ),
                  Container(
                    child: Text(products![0]!.get("price").toString() + ".00"),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              product_items = product_items! + 1;
                             
                            });
                            values.insert(index!,product_items );
                          },
                          child: Text("+")),
                      Text(product_items.toString()),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              product_items = product_items! - 1;
                              if(product_items==0){
                                   print(index);
                              }
                              values.insert(index!,product_items);
                            });

                          },
                          child: Text("-")),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                child: CachedNetworkImage(
                    width: 100, height: 120, imageUrl: products![0]!.get("image"))),
          ],

        ),

      ],
    );
  }
}
