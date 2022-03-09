import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalluri_milk/UserScreens/home_screen.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';
import 'package:kalluri_milk/main.dart';

import 'cart_screen.dart';

class addProducts extends StatefulWidget{
  final String?id;
  String? phoneNumber;
  List<String?>?datesOfCalender;
  List<DocumentSnapshot>? products = [];
  addProducts({this.id, this.phoneNumber,this.datesOfCalender,this.products});
  @override
  addProductsState createState() {
    return addProductsState(id:this.id,products:this.products);
  }
}

class addProductsState extends State<addProducts> {
   String?id;
   DateTime? pickupDate;
    var collection;
   final now = DateTime.now();
  String? time;
  String?dates;
   List<String>?datesofCalendar = [];
   List<DocumentSnapshot>? products = [];
  DocumentSnapshot<Object?>? data;
   addProductsState({this.id,this.products});
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

    int value = 0;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder(
         future: collection,
        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
             data = snapshot.data;

             return Container(
               child: Column(
                 children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                           margin: EdgeInsets.only(top: 19.6),
                           child: TextButton(
                             onPressed: () {
                               Navigator.pop(context);
                             },
                             child: Icon(
                               Icons.arrow_back_ios_rounded,
                               size: 20,
                               color: Colors.black,
                             ),
                           ),
                         ),
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40,),
                            Center(
                             child: CachedNetworkImage(imageUrl: data!.get("image"),
                             width: 240,
                               height: 140,
                             ),
                            ),
                           Container(
                             margin: EdgeInsets.only(top: 12.6),
                             alignment: Alignment.center,
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Text("Kalluri"),
                                 Text("Milk:-  "+ data!.get("productName")),
                                 Text("Quantity:- "+data!.get("quantity").toString()),
                                 Text("Price:- "+ "₹ " + data!.get("price").toString()),
                                 SizedBox(height: 80,),
                               ],
                             ),
                           )
                          ],
                        )
                       ],
                     ),
                   Expanded(
                     child: SingleChildScrollView(
                       child: Container(
                            height: 180,
                         child: ClipRRect(
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.elliptical(40, 40),
                               topRight: Radius.elliptical(40, 40)),

                           child: Container(
                             color: Colors.white,
                             child: Row(
                               children: [
                                 Container(
                                   margin: EdgeInsets.only(left: 16.3),
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                 Container(
                                           decoration: BoxDecoration(
                                               border: Border.all(
                                                 color:Color(0xfff2d695),
                                               ),
                                               borderRadius: BorderRadius.all(Radius.circular(25)),

                                           ),
                                           child: Row(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Container(
                                                  child: Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              margin:EdgeInsets.only(left:14.6),
                                                              child: Icon(Icons.calendar_today_rounded,size: 15,)),
                                                          Container(
                                                            child: TextButton(
                                                              style: ButtonStyle(
                                                              ),
                                                              onPressed: () async {
                                                                pickupDate = await showDatePicker(context: context,
                                                                 initialDate: DateTime.now(),
                                                                   firstDate: DateTime(2022),
                                                                  lastDate: DateTime(2050),
                                                                );
                                                                setState(() {
                                                                  var dates = DateFormat('EEE,d MMM').format(pickupDate!);
                                                                  datesofCalendar!.add(dates);
                                                                  print(datesofCalendar);

                                                                  Navigator.of(context).push(
                                                                      MaterialPageRoute(builder: (BuildContext
                                                                          context) =>
                                                                          WalletPage(date: datesofCalendar,)));                                                                });
                                                              },
                                                              child: Container(
                                                                width: 110,
                                                                  height: 25,
                                                                  child: Text("Schedule one time order",style: TextStyle(fontSize: 12),)),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                 ),

                                             ],
                                           ),
                                         ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15.3),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:Color(0xfff2d695),
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(25)),

                                          ),
                                           child: Row(
                                             children: [
                                               Container(
                                                   margin:EdgeInsets.only(left:14.6),
                                                   child: Icon(Icons.calendar_today_rounded,size: 15,)),
                                               Container(
                                                 child: TextButton(
                                                   style: ButtonStyle(
                                                   ),
                                                   onPressed: () {
                                                     Navigator.of(context)
                                                         .push(
                                                         MaterialPageRoute(
                                                             builder: (BuildContext
                                                             context) =>
                                                             WalletPage()));
                                                   },
                                                   child: Container(
                                                       width: 110,
                                                       height: 25,
                                                       child: Text("Set a Repeating order",style: TextStyle(fontSize: 12),)),
                                                 ),
                                               ),
                                             ],
                                           )),

                                     ],
                                   ),
                                 )
                               ],
                             ),
                         ),
                       ),
                     ),),
                   )
                 ],
               ),
             );
          }
          return Container();
        },
      )
    );
  }
}