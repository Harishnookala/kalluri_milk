import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalluri_milk/UserScreens/wallets.dart';

class add_products extends StatefulWidget {
  List<String>? date;
  String? id;
  String? Singledate;
  List?listOfWeekdays;
  List?listofpackets;
  DocumentSnapshot? products;
  List<String>? product_name;
  List? listOfvalues;
  int? product_items;
  List? listofproduct_items;
  List? listOfweekProducts;
  List<DocumentSnapshot?>?listofproducts;
   String?phonenumber;
  add_products({
    Key? key,
    this.date,
    this.id,
    this.products,
    this.product_name,
    this.Singledate,
    this.listOfvalues,
    this.product_items,
    this.listofproduct_items,
    this.listOfweekProducts,
    this.listofproducts,
    this.listofpackets,
    this.listOfWeekdays,
    this.phonenumber,
  }) : super(key: key);

  @override
  _add_productsState createState() {
    return _add_productsState(
      date: this.date,
      id: this.id,
      products: this.products,
      product_name: product_name,
      singledate: this.Singledate,
      listOfvalues: this.listOfvalues,
      product_items: this.product_items,
      listofproduct_items: this.listofproduct_items,
      listOfweekProducts: this.listOfweekProducts,
      listofproducts: this.listofproducts,
      listOfWeekdays: this.listOfWeekdays,
      listofpackets:this.listofpackets,
      phonenumber:this.phonenumber,
    );
  }
}

class _add_productsState extends State<add_products> {
  List<String>? date;
  String? id;
  var collection;
  List? listOfvalues;
  int? product_items;
  List? listOfweekProducts;
  DocumentSnapshot? products;
  List<String>? product_name;
  List<DocumentSnapshot?>?listofproducts;
  List?listofpackets;
 num? packets = 0;
  int? items = 0;
  String? dates;
  List? listofproduct_items;
  String? singledate;
  String? startdate;
  DateTime? endDate;
  List? listofweek_items;
  DateTimeRange? _selectedDateRange;
  String?phonenumber;
  var diff;
  List? listOfWeekdays;

  _add_productsState(
      {this.date,
      this.id,
      this.products,
      this.product_name,
      this.singledate,
      this.listOfvalues,
      this.product_items,
      this.listofproduct_items,
      this.listOfweekProducts,
      this.packets,
        this.phonenumber,
        this.listofpackets,
        this.listOfWeekdays,
        this.listofproducts
      });
  DateTime? pickupDate;
  DateTime? pickdate;
  String? startingdate;
  DateTimeRange? dateTimeRange;
  DocumentSnapshot<Object?>? data;
  List<DateTime> ?listofdays;
  var start;
  var end;
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .doc(id)
        .get();
    if (listOfvalues == null) {
      listOfvalues = [];
    }
    if(packets == null){
        packets =0;
     }
    if(listofpackets==null){
      listofpackets=[];
    }
    if (listofproduct_items == null) {
      listofproduct_items = [];
    }
    if (product_items == null) {
      product_items = 1;
    }
    if(listofdays==null){
      listofdays =[];
    }
    if(listofproducts==null){
      listofproducts=[];
    }
    if(listOfweekProducts ==null){
      listOfweekProducts =[];
    }
    if(listOfWeekdays==null){
      listOfWeekdays =[];
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  print(product_name);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.3),
                alignment: AlignmentDirectional.topStart,
                child:  TextButton(onPressed: (){
                    Navigator.pop(context);
                }, child: Icon(Icons.arrow_back_ios_outlined)),

              ),
              Expanded(
                child: FutureBuilder(
                    future: collection,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        data = snapshot.data;
                        String units = data!.get("category");
                        String seded = units == "Milk" ? "Ml" : "Gms";
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Card(
                                  elevation: 2.3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                          child: Center(
                                            child: CachedNetworkImage(
                                              width: 130,
                                              imageUrl: data!.get("image"),
                                            ),
                                          ),
                                          alignment: Alignment.bottomCenter,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10.3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Text(
                                                          "ProductName : - ")),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 4.3),
                                                      child: Text(data!
                                                          .get("productName"))),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10.3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Price : - "),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 6.3),
                                                    child: Text("₹ " +
                                                        data!
                                                            .get("price")
                                                            .toString()),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10.3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Quantity : - "),
                                                  Text(data!
                                                          .get("quantity")
                                                          .toString() +
                                                      " " +
                                                      seded),
                                                ],
                                              ),
                                              height: 25,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 9.6),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xfff2d695),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    Container(
                                                                        child:
                                                                            Row(
                                                                  children: [
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                14.6),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_today_rounded,
                                                                          size:
                                                                              15,
                                                                        )),
                                                                    Container(
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          pickupDate =
                                                                              await showDatePicker(
                                                                            context:
                                                                                context,
                                                                            initialDate:
                                                                                DateTime.now(),
                                                                            firstDate:
                                                                                DateTime(2022),
                                                                            lastDate:
                                                                                DateTime(2050),
                                                                          );
                                                                          var dates =
                                                                              DateFormat('EEE d MMM').format(pickupDate!);
                                                                          setState(
                                                                              () {
                                                                            singledate =
                                                                                DateFormat('EEE d MMM').format(pickupDate!);
                                                                            setState(() {
                                                                              build_date(singledate, data, product_name, listOfvalues, listofproduct_items,listOfWeekdays);
                                                                            });
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            width: 110,
                                                                            child: Text(
                                                                              "Schedule one time order",
                                                                              style: TextStyle(fontSize: 12),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 15.3,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xfff2d695),
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                14.6),
                                                                    child: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      size: 20,
                                                                    )),
                                                                Container(
                                                                  child:
                                                                      TextButton(
                                                                    style:
                                                                        ButtonStyle(),
                                                                    onPressed:
                                                                        () async {

                                                                      setState(() {
                                                                        shown_bottom_sheet(
                                                                            items,listofweek_items,data!.get("price"),
                                                                        data!.get("productName"),
                                                                         data!.get("image"),
                                                                        );
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                        width: 110,
                                                                        child: Text(
                                                                          "Set a Repeating order",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )),
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
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    }),
              ),
            ],
          ),
        ));
  }

  shown_bottom_sheet(int? items, List? listofweek_items, int price,String productname, image) {
    listOfweekProducts!.add(packets);
      showModalBottomSheet(
          elevation: 2.3,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
                listOfweekProducts!.add(packets);
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 12.3, bottom: 20.3, top: 12.3),
                          child: Text("Set Quantity"),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context,listOfweekProducts);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 18,
                            ))
                      ],
                    ),
                    diff!=null?Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:MediaQuery.of(context).size.height/3.5,
                            child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: diff+1,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    listofdays = getDaysInBetween(start,end);
                                    listofweek_items = get_weekdays(listofdays);
                                  if(diff>=listOfweekProducts!.length){
                                    listOfweekProducts!.add(packets);
                                  }
                                    return Column(
                                      children: [
                                         Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Container(
                                                 child: Text(listofweek_items![index].toString()),
                                              margin: EdgeInsets.only(left: 5.3,bottom: 5.6),
                                             )
                                           ],
                                         ),
                                        Container(
                                          margin: EdgeInsets.only(left: 15.3,right: 6.3),
                                          width: MediaQuery.of(context).size.width/10,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                child: Column(
                                                  children: [

                                                    Container(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            incrementing_buttons(index,listOfweekProducts!);
                                                          });
                                                        },
                                                        child: Text(
                                                          "+",
                                                          style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.zero,
                                                    ),
                                                     Container(
                                                    margin: EdgeInsets.only(right: 3.6),
                                                    child: Text(listOfweekProducts![index].toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,fontSize: 16))),
                                                    Container(
                                                        margin: EdgeInsets.zero,
                                                        child: TextButton(
                                                            onPressed: () {
                                                              setState((){
                                                                decrement_buttons(index,listOfweekProducts!);
                                                              });
                                                            },
                                                            child: Text(
                                                              "-",
                                                              style: TextStyle(
                                                                  color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                            )))
                                                  ],
                                                ),alignment: Alignment.topLeft,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                          ),

                        ],
                      ),
                    ):Container(),

                   ListView(
                       shrinkWrap: true,
                       physics: ScrollPhysics(),
                       children: [
                          Container(
                               alignment: Alignment.topLeft,
                               margin: EdgeInsets.only(left: 16.3, bottom: 3.6),
                               child: Text(" Set Start Date")),

                         Column(
                           children: [
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   width: MediaQuery.of(context).size.width / 1.2,
                                   alignment: Alignment.topLeft,
                                   margin:
                                   EdgeInsets.only(left: 16.3, right: 12.3, top: 5.3,bottom: 6.3),
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
                                               style: TextButton.styleFrom(
                                                   padding: EdgeInsets.zero),
                                               onPressed: () async {

                                                 dateTimeRange = await showDateRangePicker(
                                                   context: context,
                                                   firstDate:
                                                   DateTime.now().add(Duration(days: 1)),
                                                   lastDate:
                                                   DateTime.now().add(Duration(days: 360)),
                                                 );
                                                 setState(() {
                                                   dates = DateFormat('EEE  d MMM')
                                                       .format(dateTimeRange!.start);
                                                   start = dateTimeRange!.start;
                                                   end = dateTimeRange!.end;
                                                   diff = end.difference(start).inDays;

                                                 });
                                               },
                                               child: Icon(
                                                 Icons.date_range_outlined,
                                                 size: 25,
                                               ),
                                             )),
                                       ),
                                       Text(dateTimeRange != null
                                           ? dates.toString()
                                           : "Select date"),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                            Container(
                              width: 120,
                              height: 35,
                              margin: EdgeInsets.only(top: 2.3,bottom: 5.6),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xffb0d44c),
                                  elevation: 1.3,
                                ),
                                onPressed: (){
                                   listOfWeekdays = get_dates(listOfweekProducts, listofdays, data);
                                   listofpackets = get_list(listOfweekProducts);

                                 Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => WalletPage(
                                        product_name: product_name,
                                        listofvalues: listOfvalues,
                                        listofproduct_items:listofproduct_items,
                                        listOfWeekdays: listOfWeekdays,
                                        listofpackets:listofpackets,
                                        phonenumber: phonenumber,
                                      )));


                                },
                                child: listofpackets!=null?Text('Add Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),):Container(),
                              ),
                            ),
                           ],
                         ),


                       ],
                     ),

                  ],

              );
            });
          });

  }

  build_date(
    String? singledate,
    DocumentSnapshot<Object?>? data,
    List<String>? product_name,
    List? listOfvalues,
    List? listofproduct_items, List? listOfWeekdays,

  ) {
    listOfvalues!.add([
      singledate,
      [data]
    ]);
    listofproduct_items!.add(product_items);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => WalletPage(
              date: date,
              product_name: product_name,
              listofvalues: listOfvalues,
              singledate: singledate,
              listofproduct_items: listofproduct_items,
              listOfWeekdays: listOfWeekdays,
              listofpackets: listofpackets,
              phonenumber: phonenumber,
            )));
  }

  void increment() {
    setState(() {
      product_items = product_items! + 1;
    });
  }

  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

   incrementing_buttons(int index, List listOfweekProducts) {
    setState(() {
      listOfweekProducts[index]++;
    });

   }


  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  List? get_weekdays(List<DateTime>? listofdays) {
    List listofweek =[];
    String weekday;
    for(int i =0;i<listofdays!.length;i++){
      weekday = DateFormat('EEE').format(listofdays[i]);
      listofweek.add(weekday);
    }
    return listofweek;
  }

   decrement_buttons(int index, List listOfweekProducts) {
    setState(() {
      listOfweekProducts[index]--;
    });
   }

  List? get_dates(List? listOfweekProducts,listofdays, DocumentSnapshot<Object?>? data) {
      for(int j =0;j<listofdays.length;j++){
        var packets = listOfweekProducts![j];
        if(packets!=0){
          listOfWeekdays!.add([listofdays[j],data]);
        }
      }
      return listOfWeekdays;
    }

  get_list(List? listOfweekProducts) {
    for(int i =0;i<listOfweekProducts!.length;i++){
      var packets = listOfweekProducts[i];
      if(packets!=0){
        listofpackets!.add(listOfweekProducts[i]);
      }
    }
    return listofpackets;
  }

  }

