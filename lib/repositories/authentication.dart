import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kalluri_milk/models/products.dart';

class Authentication{
  CollectionReference get = FirebaseFirestore.instance.collection('Admin');

  String phone_authentication(String user_number,String otp_number){
    String?phone_number = "7995289160";
    String? number = "123456";
    if(user_number==phone_number&&otp_number==number){
      return "admin";
   }
    else{
      return "user";
    }
  }

  Future<String?>moveToStorage(File? imageFile, String? selecteditem, String text) async {
    if(imageFile!=null){
      final ref = FirebaseStorage.instance.ref().child(selecteditem!).child(text + " .jpeg");
      await ref.putFile(imageFile);
      var url = await ref.getDownloadURL();
      return url;
    }
  }
    Stream<Products?> product_values() async* {
     try{
         await get.doc("Products").collection("");
     }
     catch(e){

     }
  }
}
