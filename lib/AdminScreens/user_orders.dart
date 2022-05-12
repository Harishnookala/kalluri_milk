import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:kalluri_milk/UserScreens/displayproducts.dart';

class build_orders extends StatefulWidget {
  build_orders({Key? key}) : super(key: key);

  @override
  _build_ordersState createState() => _build_ordersState();
}

class _build_ordersState extends State<build_orders> {
  var collection;
  bool pressed = false;
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Orders")
        .collection("Order_details")
        .get();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios)),
              Expanded(
                  child: FutureBuilder<QuerySnapshot<Object?>>(
                      future: collection,
                      builder: (context, Datasnapshot) {
                        QuerySnapshot<Object?>? userData = Datasnapshot.data;
                        if (Datasnapshot.hasData) {
                          return Container(
                            child: build_data(userData),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }


  build_data(QuerySnapshot<Object?>? userData) {
    List values = get_values(userData);
    Iterable numbers = values.reversed;
    values = numbers.toList();
    DateTime?dateTime;
    var date = DateTime.now();
    var formatdate = DateFormat('EEE d MMM').format(date);

    return Container(
      margin: EdgeInsets.all(12.3),
      child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: values.length,
          itemBuilder: (context,index){
            List? listofdates = get_listof_dates(userData,values,index,formatdate);
            List?listofproducts = get_listof_products(userData, values, index, formatdate);
            List?listofprices = get_listof_prices(userData, values, index, formatdate);
            List?lisofpackets = get_listofpackets(userData, values, index, formatdate,);
            return Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  listofdates!=null?Container(
                      margin: EdgeInsets.all(12.3),
                      child: Text(values[index])):Container(),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: listofdates!.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context,count){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(listofdates[count].toString()),),
                            Container(
                              margin: EdgeInsets.all(6.3),
                              child: Card(
                                child:Container(
                                  margin: EdgeInsets.all(6.3),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Product Name : -"),
                                            Text(listofproducts![count])
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(6.3),

                                        child: Row(
                                          children: [
                                            Text("Price : -"),
                                            Text(listofprices![count].toString())
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(6.3),
                                        child: Row(
                                          children: [
                                            Text("No of Packets : -"),
                                            Text(lisofpackets![count].toString())
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(bottom: 5.6,left: 5.6),
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              color: Color(0xffb0d44c)),
                                          child: Container(
                                              child: TextButton(onPressed: (){
                                                List? listofindexes= get_documents(userData,values, index,formatdate,count);
                                                List?listofdocuments = get_listofdocuments(userData,values,index,formatdate,listofdates[count].toString());
                                                var document_id = listofdocuments![count];
                                                var indexes = listofindexes![count];
                                                FirebaseFirestore.instance.collection("Admin").doc("Orders").
                                                collection("Order_details").doc(document_id).update( {
                                                  "$indexes":[
                                                    "Deliver"
                                                  ]
                                                });
                                                }, child: Text("Deliver",style: TextStyle(color: Colors.white),))))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      })
                ],
              ),
            );
          }),
    );
  }
  get_values(QuerySnapshot<Object?>? userData) {
    String? phonenumber;
    Set numbers = HashSet();
    for (int i = 0; i < userData!.docs.length; i++) {
      DocumentSnapshot usernumber = userData.docs[i];
      phonenumber = usernumber.get("phonenumber");
      numbers.add(phonenumber);
    }
    numbers.toList();
    return numbers.toList();
  }

  List? get_listof_dates(QuerySnapshot<Object?>? userData, List values, int index,String formatdate) {
    List?listofdates =[];
    String?single_date;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          single_date =dates[j];

          listofdates.add(single_date,);
        }
      }
    }
    return listofdates;
  }
  List? get_listof_products(QuerySnapshot<Object?>? userData, List values, int index, String formatdate) {
    List?listofproducts =[];
    String?product_name;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      List products = userData.docs[i].get("Products");

      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          product_name =products[j];
          listofproducts.add(product_name,);
        }
      }
    }
    return listofproducts;
  }
  List? get_listof_prices(QuerySnapshot<Object?>? userData, List values, int index, String formatdate) {
    List?listofprices =[];
    String?pricelist;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      List prices = userData.docs[i].get("Prices");

      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          pricelist =prices[j].toString();

          listofprices.add(pricelist,);
        }
      }
    }
    return listofprices;
  }

  List? get_listofpackets(QuerySnapshot<Object?>? userData, List values, int index, String formatdate) {
    List?listofpackets =[];
    String?Singlepackets;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      List packets = userData.docs[i].get("Packets");

      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          Singlepackets =packets[j].toString();

          listofpackets.add(Singlepackets,);
        }
      }
    }
    return listofpackets;
  }

  List? get_documents(QuerySnapshot<Object?>? userData, List values, int index, String formatdate, int count) {
    List?id =[];
    for(int i=0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      for(int j = 0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          id.add(j.toString());
        }
      }
    }
    return id;
  }

  List? get_listofdocuments(QuerySnapshot<Object?>? userData, List values, int index, String formatdate, String date) {
    List?id =[];
    for (int i = 0; i < userData!.docs.length; i++) {

      List dates = userData.docs[i].get("Single Orders");

      for (int j = 0; j < dates.length; j++) {
        if (values[index] == userData.docs[i].get("phonenumber")&&formatdate==dates[j]) {
          id.add(userData.docs[i].id);
        }
      }
    }
    return id;
  }








}


