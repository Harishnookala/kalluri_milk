import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Yourorders extends StatefulWidget {
  String? phoneNumber;
  Yourorders({Key? key, this.phoneNumber}) : super(key: key);

  @override
  YourordersState createState() =>
      YourordersState(phoneNumber: this.phoneNumber);
}

class YourordersState extends State<Yourorders> {
  String? phoneNumber;
  var collection;
  List dates =[];
  List listofproducts =[];
  List listofprices =[];
  List listofpackets =[];
  String?login_number;
  YourordersState({this.phoneNumber});
  @override
  void initState()  {
    login_number = phoneNumber;
    collection = FirebaseFirestore.instance.collection("Admin").doc("Orders").collection("Order_details").get();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return WillPopScope(
     onWillPop: () async => false,
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Scaffold(
         body:  Container(
           margin: EdgeInsets.all(12.3),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Icon(Icons.arrow_back_ios)),
               Expanded(
                 child: FutureBuilder<QuerySnapshot<Object?>>(
                   future: collection,
                   builder: (context, Datasnapshot){
                     if(Datasnapshot.hasData){
                       return ListView.builder(
                           shrinkWrap: true,
                           itemCount: Datasnapshot.data!.docs.length,
                           itemBuilder: (context,index){
                             var items = Datasnapshot.data!.docs[index];
                             var usernumber = items.get("phonenumber");
                             var get_data = get_snapshot(items);
                             dates.add(get_data);
                             var products = get_products(items);
                             listofproducts.add(products);
                             var prices = get_prices(items);
                             listofprices.add(prices);
                             var packets = get_packets(items);
                             listofpackets.add(packets);
                            return build_data(usernumber,login_number,index,dates,products,prices,packets,items);

                              return Container();
                           });

                     }
                     else{
                       return Center(child: CircularProgressIndicator(),);
                     }
                   },

                 ),
               ),
             ],
           ),
         ),
       ),
     ),
   );
  }

  void get_data(collection) {

 /*   collection.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
      });
    });*/
  }

  get_snapshot(QueryDocumentSnapshot<Object?> items, ) {

   var status;
   var phonenumber;
    List data = [];

   phoneNumber = items.get("phonenumber");
   var Single_dates= items.get(["Single Orders"][0]);
    return Single_dates;
  }

  get_products(QueryDocumentSnapshot<Object?> items) {
    var products = items.get("Products");
    return products;
  }

  get_prices(QueryDocumentSnapshot<Object?> items) {
    var prices = items.get("Prices");
    return prices;
  }

  get_packets(QueryDocumentSnapshot<Object?> items) {
    var packets = items.get("Packets");
    return packets;
  }

   build_data(usernumber, String? login_number, int index, List dates, products, prices, packets, QueryDocumentSnapshot<Object?> items) {
       return usernumber==login_number? Container(
         child: Column(
           children: [
             ListView.builder(
               physics: ScrollPhysics(),
                 itemCount: dates[index].length,
                 shrinkWrap: true,
                 itemBuilder: (context, count){
                var delivery= items.get("$count");
                var value = delivery[0];
                print(value);
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         child: Row(
                           children: [
                             Container(
                               child: Icon(Icons.shopping_bag),
                               margin: EdgeInsets.only(right: 9.6),
                             ),
                             Text(dates[index][count]),

                           ],
                         ),
                       ),
                       SizedBox(
                         child: Card(
                           elevation: 2.0,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(9.5),
                           ),
                           child: Container(
                             margin: EdgeInsets.all(9.6),

                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.start,

                               children: [
                                 Container(
                                   margin: EdgeInsets.all(5.6),
                                   child: Row(

                                     children: [
                                       Text("Product Name :-  "),
                                       Text(listofproducts[index][count]),
                                     ],
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     crossAxisAlignment: CrossAxisAlignment.start,

                                   ),
                                 ),
                                 Container(
                                   margin: EdgeInsets.all(5.6),

                                   child: Row(
                                     children: [
                                       Text("Price : - "),
                                       Text(listofprices[index][count].toString()),
                                     ],
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     crossAxisAlignment: CrossAxisAlignment.start,

                                   ),
                                 ),
                                 Container(
                                   margin: EdgeInsets.all(5.6),

                                   child: Row(
                                     children: [
                                       Text("no of packets : - "),
                                       Text(listofpackets[index][count].toString()),
                                     ],
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                   ),
                                 ),
                                 value=="Deliver"?Container(
                                   alignment: Alignment.topLeft,
                                   margin: EdgeInsets.only(top: 12.3,bottom: 6.9,left: 12.3),
                                   child: Text("Delivered",style: TextStyle(color: Colors.red),),):Container()
                               ],
                             ),
                           ),
                         ),
                       )
                     ],
                   );

                 }),

           ],
         ),
       ):Container();
     }

  get_draft(QueryDocumentSnapshot<Object?> items) {
  }
   }







