import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalluri_milk/UserScreens/wallets.dart';

class add_products extends StatefulWidget {
  List<String>? date;
  String? id;
  String?Singledate;
  List<DocumentSnapshot>? products;
  List<String>? product_name;
  List?listOfvalues;
  add_products({
    Key? key,
    this.date,
    this.id,
    this.products,
    this.product_name,
   this.Singledate,
    this.listOfvalues
  }) : super(key: key);

  @override
  _add_productsState createState() {
    return _add_productsState(
        date: this.date,
        id: this.id,
        products: this.products,
        product_name: product_name,
       singledate: this.Singledate,
       listOfvalues:this.listOfvalues,
    );
  }
}

class _add_productsState extends State<add_products> {
  List<String>? date;
  String? id;
  var collection;
  List?listOfvalues;
  List<DocumentSnapshot>? products;
  List<String>? product_name;

  String? dates;

  String? singledate;
  _add_productsState({this.date, this.id, this.products, this.product_name,this.singledate,this.listOfvalues});
  DateTime? pickupDate;
  DateTime?startingdate;
  DocumentSnapshot<Object?>? data;
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .doc(id)
        .get();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Container(
          child: Column(
            children: [
              FutureBuilder(
                  future: collection,
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      data = snapshot.data;
                      String units = data!.get("category");
                      String seded = units == "Milk" ? "Ml" : "Gms";
                      return Container(
                        margin: EdgeInsets.all(20.3),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: data!.get("image"),
                                  ),
                                ),
                                alignment: Alignment.bottomCenter,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10.3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(child: Text("ProductName")),
                                        Container(
                                            child:
                                                Text(data!.get("productName"))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10.3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Price "),
                                        Text("₹ " +
                                            data!.get("price").toString())
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10.3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Quantity "),
                                        Text(data!.get("quantity").toString() +
                                            " " +
                                            seded)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      );
                    }
                    return Container();
                  }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        pickupDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );
                        singledate = DateFormat('EEE-d MMM').format(pickupDate!);
                        setState(() {
                          if (date == null || products == null||listOfvalues==null) {
                            date = [];
                            listOfvalues =[];
                            products = [];
                            products!.add(data!);
                            date!.add(singledate!);
                            List dates = [];
                            dates.add(singledate);
                            List value = [];
                            value.add(id);
                            dates.add(value);
                            listOfvalues!.add(dates);

                          } else {
                            print(date);
                            date!.add(singledate!);
                            products!.add(data!);
                            List dates = [];
                            dates.add(singledate);
                            List value = [];
                            value.add(id);
                            dates.add(value);
                            listOfvalues!.add(dates);
                            print(listOfvalues);
                          }
                          print(listOfvalues);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => WalletPage(
                                    date: date,
                                    products: products,
                                    product_name: product_name,
                                    listofvalues:listOfvalues,
                                  )));
                        });
                      },
                      child: Text("Add Once")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          shown_bottom_sheet();
                        });
                      },
                      child: Text("Add for week")),
                ],
              )
            ],
          ),
        ));
  }

  shown_bottom_sheet() {
    List week = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12.3, bottom: 20.3, top: 12.3),
                  child: Text("Set Quantity"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 18,
                    ))
              ],
            ),
            
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height/4,
                     child:ListView.builder(
                          shrinkWrap: true,
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15.3),
                                  width: MediaQuery.of(context).size.width/11,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(week[index]),
                                        margin: EdgeInsets.only(bottom: 2.6, left: 2.6),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(25.0)),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: TextButton(
                                                onPressed: () {
                                                  print(index);
                                                },
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                              margin: EdgeInsets.zero,
                                            ),
                                            Container(
                                                margin: EdgeInsets.zero,
                                                child: Text("0",
                                                    style: TextStyle(
                                                        color: Colors.black))),
                                            Container(
                                                margin: EdgeInsets.zero,
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 12.3),
                        child: Text(" Set Start Date")),
                        Container(
                          margin: EdgeInsets.only(left: 12.3,right: 12.3,top: 5.3),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(1.3)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Container(
                                  child: TextButton(
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                     onPressed: ()async{
                                       startingdate = await showDatePicker(
                                         context: context,
                                         initialDate: DateTime.now(),
                                         firstDate: DateTime.now(),
                                         lastDate: DateTime(2050),
                                       );
                                        setState(() {
                                          dates = DateFormat('EEE,MMM,d').format(startingdate!);
                                        });
                                       print(dates);
                                     },
                                    child: Icon(Icons.calendar_today,size: 25,),
                                  )
                                ),
                              ),
                              Center(child:dates!=null?Text(dates!):Container(child:Text(DateTime.now().toString())))
                            ],
                          ),
                        )
                  ],
                ),
             ),
            
          ],
        );
      },
    );
  }
}
