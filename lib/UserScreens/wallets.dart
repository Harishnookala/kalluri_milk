import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

class WalletPage extends StatefulWidget {
  List<String>? date;
  DocumentSnapshot? products;
  List<String>? product_name;
  List? listofvalues;
  String? singledate;
  int? product_items;
  List? noOfitems;
  List? listofproduct_items;
  List?listOfWeekdays;
  String? phonenumber;
  List<DocumentSnapshot?>?listofproducts;
  List?listofpackets;
  WalletPage({
    Key? key,
    this.date,
    this.products,
    this.product_name,
    this.listofvalues,
    this.singledate,
    this.product_items,
    this.noOfitems,
    this.listofproduct_items,
    this.listOfWeekdays,
    this.listofproducts,
  this.listofpackets,
    this.phonenumber,
  }) : super(key: key);

  @override
  _WalletPageState createState() {
    return _WalletPageState(
      date: this.date,
      products: this.products,
      product_name: this.product_name,
      listofvalues: this.listofvalues,
      singledate: this.singledate,
      product_items: this.product_items,
      noOfitems: this.noOfitems,
      listofproduct_items:this.listofproduct_items,
      listOfWeekdays:this.listOfWeekdays,
      listofproducts:this.listofproducts,
      listofpackets:this.listofpackets,
      phoneNumber:this.phonenumber,
    );
  }
}

class _WalletPageState extends State<WalletPage> {
  final databasereference = FirebaseDatabase.instance.ref().child("AdminOrders");
  List<String>? date;
  List? noOfitems;
  DocumentSnapshot? products;
  List?listOfWeekdays;
  Authentication authentication = Authentication();
  List? value;
  List? listofvalues;
  int? product_items;
  List<DocumentSnapshot?>?listofproducts;
  List<String>? product_name;
  String? singledate;
  var total;
  var items = 0;
  String? product_values;
  List? listofproduct_items;
  List?listofpackets;
  int? values = 0;
  String?phoneNumber;
  String?status;
  _WalletPageState({
    this.date,
    this.products,
    this.value,
    this.product_name,
    this.listofvalues,
    this.singledate,
    this.product_items,
    this.noOfitems,
    this.listofproduct_items,
    this.listOfWeekdays,
    this.listofproducts,
    this.listofpackets,
    this.phoneNumber,
  });

  @override
  void initState() {
    if (value == null) {
      value = [];
    }
    if (noOfitems == null) {
      noOfitems = [];
    }
    if (product_items == null) {
      product_items = 0;
    }
    if (product_name == null) {
      product_name = [];
    }
   if(status==null){
     status = "Draft";
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff8ebce),
          bottom: TabBar(
            tabs: [
              Container(
                  margin: EdgeInsets.all(11.3),
                  child: Text("Tomorrow's Order",
                      style: TextStyle(
                        color: Colors.black,
                      ))),
              Container(
                  margin: EdgeInsets.all(11.3),
                  child: Text("Weekly  Order",
                      style: TextStyle(
                        color: Colors.black,
                      )))
            ],
          ),
          title: Text('Wallet',
              style: TextStyle(
                color: Colors.black,
              )),
        ),

        body: TabBarView(
          children: [
              listofvalues!=null?build_today_orders(date,products,product_name,listofvalues,singledate,listOfWeekdays,listofpackets,phoneNumber):Container(),
             listOfWeekdays!=null?buildScheduleorders(product_name,listOfWeekdays,listofpackets,listofvalues,listofproduct_items,phoneNumber):Container()
          ],
        ),
      ),
    );
  }

  build_today_orders(List<String>? date, DocumentSnapshot? products,
      List<String>? product_name, List? listofvalues, String? singledate,List?listOfWeekdays, List? listofpackets,String? phoneNumber ) {

    num noOfitems;
    DateTime? dateTime = DateTime.now().add(Duration(days: 1));
    var dates = DateFormat('EEE,d MMM').format(dateTime);
    return listofvalues!=null?build_orders(product_name,listofvalues,listOfWeekdays,listofpackets,phoneNumber):Container(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>userPannel(
                    dates: date,
                    listofvalues: listofvalues,
                    product_name: product_name,
                    listofproduct_items: listofproduct_items,
                    listOfWeekdays:listOfWeekdays,
                    listofpackets:listofpackets,
                    values: values)));
          },
          child: Text("Add items"),
        ));
  }

  build_weekly_orders(
      List<String> product_name,
     List? listOfWeekdays, List?listofpackets,List?listofvalues,List?listofproduct_items,) {

  return buildScheduleorders(product_name,listOfWeekdays,listofpackets,listofvalues,listofproduct_items,phoneNumber!);

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



  build_orders(product_name,listofvalues,listOfWeekdays,listofpackets, String?phoneNumber) {
    DocumentSnapshot? documentSnapshot;
    var total_price;

    if(listofvalues!=null){
      total_price = authentication.get_totalValues(
          values, products, listofproduct_items, listofvalues!);
      values = listofproduct_items!.length;
    }

    return listofvalues!=null? ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: listofvalues!.length,
                itemBuilder: (context, index) {
                  List<DocumentSnapshot<Object?>?> products =
                  listofvalues![index][1];
                  List values_of_items = [];
                  values_of_items.add(products);
                  var get_it = products[0]!.data();
                  var content = json.encode(get_it.toString());
                  var category = products[0]!.get("category");
                  var units = category == "Milk" ? "Ml" : "Gms";
                  var packet = category == "Milk" ? "Tetra Packet" :category=="Ghee"?"GlassBottle":"Packet";
                  return Container(
                    margin: EdgeInsets.only(
                        left: 12.3, right: 12.3, bottom: 2.0, top: 12.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.shopping_bag),
                                margin: EdgeInsets.only(right: 2.3),
                              ),
                              Container(
                                  child: Text(listofvalues![index][0]))
                            ],
                          ),
                        ),
                        build_products(units,packet,index,products,phoneNumber)
                      ],
                    ),
                  );
                }),
            listofvalues != null
                ? ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                userPannel(
                                    dates: date,
                                    listofvalues: listofvalues,
                                    product_name: product_name,
                                    listofproduct_items:
                                    listofproduct_items,
                                    listOfWeekdays: listOfWeekdays,
                                    listofpackets: listofpackets,
                                    values: values,
                                    phoneNumber: phoneNumber,
                                )));
                      },
                      child: Text(" + Add products")),
                ),
                if (listofvalues!.length!=0) Container(
                  height: MediaQuery.of(context).size.height/6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    child: Center(
                      child: Container(
                          height: 35,
                          width: 125,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10.0),
                              color: Color(0xffb0d44c)),
                          child: TextButton(
                              onPressed: () async{


                                List? list = authentication.get_data(listofvalues, listofproduct_items);

                                List? listofproducts = getproducts(products,listofproduct_items,listofvalues);
                                List?listofprices  = get_prices(listofvalues);
                                List?listofpackets = get_items(listofproduct_items);
                                Map<String,dynamic> db ={
                                  "phonenumber":phoneNumber,
                                         "Single Orders":[
                                            for(int i =0;i<list!.length;i++)
                                            list[i],
                                         ],
                                     "Products":[
                                       for(int i =0;i<listofproducts!.length;i++)
                                         listofproducts[i],
                                     ],
                                   "Prices":[
                                     for(int i =0;i<listofprices!.length;i++)
                                       listofprices[i],

                                   ],
                                  "Packets":[
                                    for(int i =0;i<listofpackets!.length;i++)
                                      listofpackets[i]
                                  ],
                                   for(int i =0;i<list.length;i++)
                                     "$i":["Draft"]
                                };
                             /*   var db = {
                                  "total": total_price,
                                  "phonenumber": phoneNumber,
                                  "Status": status,
                                  "Dates": {
                                    "products": listofproducts,
                                  },
                                };*/
                            /*  await databasereference.push().set(db);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        userPannel(phoneNumber: phoneNumber,)));*/
                               await FirebaseFirestore.instance.collection("Admin").doc("Orders").collection("Order_details").doc().set(db);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        userPannel(phoneNumber: phoneNumber,)));
                              },

                              child: Text(
                                "Buy Products",
                                style:
                                TextStyle(color: Colors.black),
                              ))),
                    ),
                  ),
                ) else Center(child: Text("No Items added"),),
              ],
            )
                : Container(
              child: Text("Harsih"),
            ),

          ],
        ),
        listofvalues!=null?Container(
          alignment:Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.3),
                topRight: Radius.circular(25.3)),
            color: Color(0xfff9edd3),
          ),
          height: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Items"),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(top: 2.3, left: 6),
                      child: VerticalDivider(
                        thickness: 1.3,
                        width: 3.6,
                        color: Colors.black,
                      ),
                    ),
                    Text("Grand total"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(2.3),
                    child: Text(listofvalues.length.toString()),
                  ),
                  Container(
                    height: 13,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(2.3),
                    child: Text("₹ " + total_price.toString()),
                  ),
                ],
              ),
            ],
          ),
        )
            : Container(),
      ],
    ):Container();
  }

  buildScheduleorders(List?productname,List?listOfWeekdays, List? listofpackets, List? listofvalues, List? listofproduct_items, String? phoneNumber,) {
 DocumentSnapshot? details;
String?daysformat;
  num total =0;

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.3),
            child: ListView(
              shrinkWrap: true,
              children: [
                  ListView.builder(
                        itemCount: listOfWeekdays!.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context,index){
                        daysformat = DateFormat("EEE  d MMM").format(listOfWeekdays[index][0]);
                        details = listOfWeekdays[index][1];
                        var units = details!.get("category") == "Milk" ? "Ml" : "Gms";
                        var packet = details!.get("category") == "Milk" ? "Tetra Packet" : "Packet";
                        return Container(
                         child:Column(
                           children: [
                             Row(
                               children: [
                                 Icon(Icons.shopping_bag),
                                 Container(
                                   margin: EdgeInsets.all(12.3),
                                   child: Text(daysformat!),
                                 ),

                               ],
                             ),

                                    ListView(
                                       shrinkWrap:true,
                                       physics: ScrollPhysics(),
                                       children: [
                                         SizedBox(
                                           height:MediaQuery.of(context).size.height/3.5,
                                           child: Card(
                                             elevation: 1.6,
                                             shape: RoundedRectangleBorder(borderRadius:
                                               BorderRadius.circular(8.5),
                                             ),
                                             child: Container(
                                               margin: EdgeInsets.only(left: 9.3,top: 9.6,bottom: 5.6),
                                               child: Row(
                                                 children: [
                                                   Column(

                                                     children: [
                                                       Container(child: Text("Kalluri",style: TextStyle(color: Colors.grey,fontFamily: "Poppins",fontSize:15),),),
                                                      Container(
                                                        margin: EdgeInsets.only(top:3.6,),
                                                        child: Text(details!.get("productName"),
                                                          style: TextStyle(color: Colors.black87,fontFamily: "Poppins",fontSize:14)),),
                                                       Container(
                                                         margin: EdgeInsets.only(top: 4.6,),

                                                         child: Text(details!.get("quantity").toString() + " "+units + " "+ packet),),
                                                       Container(
                                                         margin: EdgeInsets.only(top: 5.6,bottom: 5.6),

                                                         child: Text("₹ "+ details!.get("price").toString()),),
                                                       Row(
                                                         crossAxisAlignment: CrossAxisAlignment.center,
                                                         mainAxisAlignment: MainAxisAlignment.start,
                                                         children: [
                                                           SizedBox(
                                                             height: 35,
                                                             child: TextButton(
                                                                 style: TextButton.styleFrom(
                                                                   backgroundColor: Color(0xfff4deac),
                                                                   shape: RoundedRectangleBorder(
                                                                     side: BorderSide(color: Color(0xfff4deac)),
                                                                     borderRadius:
                                                                     BorderRadius.circular(25.0),
                                                                   ),
                                                                 ),
                                                                 onPressed: () {
                                                                   setState(() {
                                                                      values = listofpackets![index];
                                                                      increment_week(values,index);
                                                                   });
                                                                 },
                                                                 child: Text(" + ", style: TextStyle(
                                                                     color: Colors.black),
                                                                 )),
                                                           ),
                                                           Container(
                                                               margin: EdgeInsets.only(
                                                                   left: 5.3,
                                                                   right: 5.3),
                                                               child: Text(
                                                                 listofpackets![index].toString(),
                                                                 style: TextStyle(fontSize: 16),
                                                               )),
                                                           SizedBox(
                                                             height: 35,
                                                             child: TextButton(
                                                                 style: TextButton.styleFrom(
                                                                   backgroundColor:
                                                                   Color(0xfff4deac),
                                                                   shape: RoundedRectangleBorder(
                                                                     side: BorderSide(color: Color(0xfff4deac)),
                                                                     borderRadius: BorderRadius.circular(25.0),
                                                                   ),
                                                                 ),
                                                                 onPressed: () {
                                                                   setState(() {
                                                                      decrement_week(index,details);
                                                                   });
                                                                 },
                                                                 child: Container(
                                                                     alignment: Alignment.topLeft,
                                                                     child: Text(" -", style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontWeight: FontWeight.w900,
                                                                         fontSize: 18),
                                                                     ))),
                                                           ),
                                                         ],
                                                       ),

                                                     ],
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                   ),

                                                  Container(
                                                          child: CachedNetworkImage(imageUrl: details!.get("image"),width: 100,height: 60),

                                                  ),
                                                 ],
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                               ),
                                             ),

                                           ),
                                         )
                                       ],
                                     ),



                           ],
                         )
                       );
                    }),
                SizedBox(

                  child: Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  userPannel(
                                      dates: date,
                                      listofvalues: listofvalues,
                                      product_name: product_name,
                                      listofproduct_items: listofproduct_items,
                                     listofproducts: listofproducts,
                                      listofpackets:listofpackets,
                                      listOfWeekdays:listOfWeekdays,
                                      values: values,
                                      phoneNumber: phoneNumber,
                                  )));
                        },
                        child: Text(" + Add products")),
                  ),
                ),
                 Center(
                   child: Container(
                      height: 35,
                      width: 125,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10.0),
                          color: Color(0xffb0d44c)),
                      child: TextButton(
                          onPressed: () {
                          },
                          child: Text(
                            "Buy Products",
                            style:
                            TextStyle(color: Colors.black,fontFamily: "poppins"),
                          ))),
                 ),

              ],
            )
          ),
        ),
          listOfWeekdays!=null?Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.3),
                  topRight: Radius.circular(25.3)),
              color: Color(0xfff9edd3),
            ),
            height: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Items"),
                      Container(
                        height: 55,
                        margin: EdgeInsets.only(top: 2.3, left: 6),
                        child: VerticalDivider(
                          thickness: 1.3,
                          width: 3.6,
                          color: Colors.black,
                        ),
                      ),
                      Text("Grand total"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2.3),
                      child: Text(listOfWeekdays.length.toString()),
                    ),
                    Container(
                      height: 13,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(2.3),
                      child: Text("₹ " + authentication.get_week_total(listOfWeekdays,listofpackets).toString()),
                    ),
                  ],
                ),
              ],
            ),
          )
              : Container(),
      ],
    );
  }

  build_products(units,packet,index, List<DocumentSnapshot<Object?>?> products, String?phoneNumber) {

    return Column(
      children: [
        SizedBox(
          child: Card(
            elevation: 2.3,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(8.5),
            ),
            child: Container(
              margin: EdgeInsets.all(2.4),
              child: Column(
                children: [
                  Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4.3, bottom: 3.3),
                                child: Text(
                                  "Kalluri",
                                  style: TextStyle(color: Colors.black54,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(top: 4.3, bottom: 6.3),
                                child: Text(
                                  products[0]!.get("productName"),
                                  style: TextStyle(color: Colors.black, fontFamily: "Poppins-Medium"),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 4.3, bottom: 6.3),
                                  child: Text(products[0]!.get("quantity").toString()
                                      + " " +
                                      units +
                                      " ")),
                              Container(
                                  margin:
                                  EdgeInsets.only(top: 4.3, bottom: 6.3),
                                  child: Text(packet)),
                              Container(
                                  margin: EdgeInsets.only(top: 4.3, bottom: 6.3),
                                  child: Text("₹" + products[0]!.get("price").toString() + " ")),
                              Container(
                                margin: EdgeInsets.only(top: 8.3),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xfff4deac),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Color(0xfff4deac)),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            values = index;
                                                if (values == index) {
                                                  increment_counter(index, values);
                                                }
                                              });
                                        },
                                        child: Text(" + ", style: TextStyle(
                                              color: Colors.black),
                                        )),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 5.3,
                                          right: 5.3),
                                      child: Text(
                                        listofproduct_items![index].toString(),
                                        style: TextStyle(fontSize: 16),
                                      )),
                                  SizedBox(
                                    height: 35,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                          Color(0xfff4deac),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Color(0xfff4deac)),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                                values = index;
                                                if (values == index) {
                                                  decrement_counter(index, values);
                                                }
                                              });
                                        },
                                        child: Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(" -", style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 18),
                                            ))),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Center(
                            child: Container(
                              child: CachedNetworkImage(
                                  width: 100,
                                  height: 80,
                                  imageUrl: products[0]!.get("image")),
                              margin: EdgeInsets.only(top: 12.9),
                            ),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 12.3, bottom: 9.3, left: 12.3,
                          right: 12.3))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void increment_counter(int? index, int? values) {
    if (index == values) {
      listofproduct_items![index!]++;
    }
  }

  void decrement_counter(int? index, int? values) {
    if (index == values) {
      listofproduct_items![index!]--;
      if (listofproduct_items![index] == 0) {
        listofproduct_items!.removeAt(index);
        listofvalues!.removeAt(index);
        product_name!.removeAt(index);
      }
    }
  }
   increment_week(int? values, int index) {
       listofpackets![index]++;
   }

   decrement_week(int index, DocumentSnapshot<Object?>? details) {
   setState(() {
     listofpackets![index]--;
     if(listofpackets![index]==0){
       listOfWeekdays!.removeAt(index);
       listofpackets!.removeAt(index);
      if(product_name!.length!=0){
        if(details!.get("productName")==product_name![index]){
          product_name!.removeAt(index);
        }
      }
     }
   });
   }

  List? getproducts(DocumentSnapshot<Object?>? products, List? listofproduct_items, listofvalues) {
    num price = 0;
    String?productname;
    int? quantity;
    String? date;
    List?listofdates =[];
    List listofproducts = [];
    if (listofvalues != null) {
      for (int i = 0; i < listofvalues.length; i++) {
        date = listofvalues[i][0];
        List<DocumentSnapshot<Object?>?> products = listofvalues[i][1];
        for (int j = i; j <= i; j++) {
           productname = products[0]!.get("productName");
           price = products[0]!.get("price");
           quantity = products[0]!.get("quantity");
           product_items = listofproduct_items![i];
        }
        listofproducts.add(productname);


      }
    }
   return listofproducts;
  }

  List? get_prices(listofvalues) {
     var prices;
    List? listofprices =[];
     for(int i =0;i<listofvalues.length;i++){
       List<DocumentSnapshot<Object?>?> products = listofvalues[i][1];
       for (int j = i; j <= i; j++) {
         prices = products[0]!.get("price");
       }
       listofprices.add(prices);
     }
     return listofprices;
  }

  List? get_items(List? listofproduct_items) {
    var packets;
    List?listofitems =[];
    for(int i =0;i<listofproduct_items!.length;i++){
      listofitems.add(listofproduct_items[i]);
    }
   return listofitems;
  }






   }



