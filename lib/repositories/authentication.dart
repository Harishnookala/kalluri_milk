import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/AdminScreens/edit_data.dart';
import 'package:kalluri_milk/models/products.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Authentication {
  CollectionReference get = FirebaseFirestore.instance.collection('Admin');



  String? adminAuthentication(String admin_number,String otp) {
    String? phone_number = "7995289160";
    String? number = "123456";
    if (admin_number == phone_number && otp == number) {
      return "admin";
    }
    else{
      return userAuthentication(admin_number, otp);
    }
  }
  String?userAuthentication(String usernumber,String otp_number){
    List phone_numbers =["8919740894","9440468098"];
    List otp_numbers = ["40894","94404"];
         if(phone_numbers.contains(usernumber)){
           if(otp_numbers.contains(otp_number)){
             return "Valid";
           }
         }
         return "not Valid";
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

   product_values() async  {
   var doc_id;
     CollectionReference _collectionRef =
     FirebaseFirestore.instance.collection('Admin').doc("Products").collection("Product_details");
     Future<QuerySnapshot<Object?>> querySnapshot =  _collectionRef.get();
     var value = await querySnapshot;
     if(value.docs.length>0){
       for(int i = 0;i<value.docs.length;i++){
         print("Harish");
         DocumentSnapshot documentSnapshot = value.docs[i];
           doc_id =  documentSnapshot.id;
       }
       return doc_id;
     }
     else{
       return null;
     }
  }

  get_categories(QuerySnapshot<Object?>? data) {
    Set categories = HashSet();
    String? category;
    for (int i = 0; i < data!.docs.length; i++) {
      DocumentSnapshot product = data.docs[i];
       category = product.get("category");
         categories.add(category);
    }
    categories.toList();

    return categories.toList();
  }
  List<String>?get_dates(List<String>? date){
     Set<String>? alldates = HashSet();
     String? selected_dates;
     if(date!.isNotEmpty){
     for(int i=0;i<date.length;i++){
       selected_dates =date[i];
       alldates.add(selected_dates);
     }
     return alldates.toList();
     }
     else{
       return null;
     }

  }
  List? get_names(List<QueryDocumentSnapshot<Object?>>docs){
    List names = [];
     for(int i=0;i<docs.length;i++){
       names.add(docs[i].get("productName"));
     }
    return names.toList();
  }
  List<String>? get_values(List<DocumentSnapshot<Object?>>? products, List<String>? date){
    List<List<List<int>>> numbers =  [];

    Set<String>? alldates = HashSet();
    List values =[];
    values.add(products![0].get("productName"));


    print(numbers);
  }

  List? getProductswithdates(List<DocumentSnapshot<Object?>>? products, List<String>? date, String? singledate) {
   Map map = Map();
   List values =[];
      map = {
      "date":{
        for(int i=0;i<date!.length;i++){

        }
      },
    };

    }

  get_id(List? listofvalues) {
    List idea = [];
    List list =[];
    List get =[];

  //  [               [ [16 mar][121][10034]  ],]

    List<Object> list1=[] ;
    List<Object> list2=[];
    List<Object> list3=[];

    //list3.add([])

    list2.add("element1");

    list1.add("element2");
    list1.add("element3");
   // list1.add("element4");

    list2.add(list1);

    list3.add(list2);

    print(list3.toString() + "Siva");

    // List <Object> listobj=[];
    // listobj.addAll(list2);
    //
    // listobj.add("element3");
    // listobj.add("element4");
    // print(listobj);







  }

}

