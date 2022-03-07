import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

class productsPage extends StatefulWidget{
  String? phoneNumber;
  productsPage({this.phoneNumber});
  @override
  productsPageState createState() => productsPageState(phoneNumber:this.phoneNumber);
}

class productsPageState extends State<productsPage>{
  var collection;
  String? phoneNumber;
  Authentication authentication = Authentication();
  productsPageState({this.phoneNumber});
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .snapshots();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(left: 9.3),
        child: StreamBuilder<QuerySnapshot>(
            stream: collection,
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                QuerySnapshot<Object?>? userData = snapshot.data;
                List categories = authentication.get_categories(userData);
                Iterable products = categories.reversed;
                categories = products.toList();
                return Container(

                );
              }
              return CircularProgressIndicator();
            }
        )
    );
  }

}