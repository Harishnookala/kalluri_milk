import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

class shownProducts extends StatefulWidget {
  @override
  ShownProductsState createState() => ShownProductsState();
}

class ShownProductsState extends State<shownProducts> {
  Authentication authentication = Authentication();
  Future<QuerySnapshot<Map<String, dynamic>>> querySnapshot =  FirebaseFirestore.instance.collection("collection").get();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Container();
}}
