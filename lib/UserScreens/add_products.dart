import 'package:flutter/material.dart';

class addProducts extends StatefulWidget{
  String?id;
  addProducts({this.id});

  @override
  addProductsState createState() {
    return addProductsState(id:this.id);
  }

}

class addProductsState extends State<addProducts> {
  String?id;
   addProductsState({this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}