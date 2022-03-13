import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

class WalletPage extends StatefulWidget {
  List<String>? date;
  List<DocumentSnapshot>? products;
  List<String>?product_name;
  List? listofvalues;
  String? singledate;
  WalletPage({Key? key, this.date, this.products,this.product_name, this.listofvalues,this.singledate }) : super(key: key);

  @override
  _WalletPageState createState() {
    return _WalletPageState(date: this.date, products: this.products,product_name:this.product_name,listofvalues:listofvalues);
  }
}

class _WalletPageState extends State<WalletPage> {
  List<String>? date;
  List<DocumentSnapshot>? products;
  Authentication authentication = Authentication();
  int? value = 0;
  List? listofvalues;
  List<String>?product_name;
  String? singledate;
  _WalletPageState({this.date, this.products, this.value,this.product_name,this.listofvalues,this.singledate});
  @override
    void initState(){
     if(value ==null){
       value = 0;
     }
     super.initState();
   }
  @override

  Widget build(BuildContext context) {
    DateTime? datetime = DateTime.now();
    var tomorrow = datetime.day + 1;
  print(listofvalues);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff1d799),
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
              build_today_orders(date, products,tomorrow,product_name,listofvalues),
              build_weekly_orders(date, products, tomorrow,product_name!,listofvalues,singledate)
            ],
          ),
        ));
  }

  build_today_orders(List<String>? date, List<DocumentSnapshot<Object?>>? products, int tomorrow, List<String>? product_name, List? listofvalues) {
    var  itemcount = products!.length==1?products.length:products.length/2;
    return date!=null?Container(
        margin: EdgeInsets.only(top: 11.3, left: 8.3, right: 7.8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: date.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var dates = date[index].replaceAll(new RegExp(r'[^0-9]'), ''); // '23'
                          var finddate = int.parse(dates);
                          if (tomorrow == finddate) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(date[index]),
                                  margin: EdgeInsets.all(10.3),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: products.length,
                                    physics:ScrollPhysics(),
                                    itemBuilder: (context, count) {
                                      var category = products[count].get("category");
                                      var units = category == "Milk" ? "Ml" : "Gms";
                                      var packet =
                                      category == "Milk" ? "Tetra Packet" : "";
                                      return Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Card(
                                                elevation: 2.3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.5),
                                                ),
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
                                                                  margin: EdgeInsets.only(top: 4.3,bottom: 6.3),

                                                                  child: Text(
                                                                    "Kalluri",
                                                                    style: TextStyle(color: Colors.black54,
                                                                        fontFamily: "Poppins"),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: 4.3,bottom: 6.3),

                                                                  child: Text(products[index].get("productName"),
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontFamily: "Poppins-Medium"),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets.only(top: 4.3,bottom: 6.3),
                                                                    child: Text(products[index].get("quantity").toString() + " " + units)),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: 4.3,bottom: 12.3),
                                                                  child: Text(packet),
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:55,
                                                                      height: 35,
                                                                      child: Container(
                                                                        child: TextButton(
                                                                          onPressed: () {

                                                                          },
                                                                          child: Container(
                                                                            alignment: Alignment.center,
                                                                            child: Text(" - ",textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.black,
                                                                                fontSize: 18,),
                                                                            ),

                                                                          ),
                                                                          style: TextButton.styleFrom(backgroundColor: Color(0xfff4deac),
                                                                            shape: RoundedRectangleBorder(
                                                                              side: BorderSide(color: Color(0xfff4deac)),
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                            ),

                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child: Container(
                                                                        margin: EdgeInsets.only(left: 10.3,right: 10.3),
                                                                        child: (Text(value.toString())),
                                                                        alignment: Alignment.center,

                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:55,
                                                                      height:35,
                                                                      child: Container(
                                                                        child: TextButton(
                                                                          onPressed: () {
                                                                            print("siva" + value.toString());
                                                                          },
                                                                          child: Container(
                                                                            child: Text("+",
                                                                              style: TextStyle(color: Colors.black,
                                                                                  fontSize: 18),
                                                                            ),

                                                                          ),
                                                                          style: TextButton.styleFrom(backgroundColor: Color(0xfff4deac),
                                                                            shape: RoundedRectangleBorder(
                                                                              side: BorderSide(color: Color(0xfff4deac)),
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                            ),

                                                                          ),
                                                                        ),

                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            Center(child: CachedNetworkImage(
                                                                width: 120,
                                                                height: 120,
                                                                imageUrl: products[index].get("image")))
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.only(top: 12.3,bottom: 20.3,left: 12.3,right: 12.3)
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),

                              ],
                            );
                          }
                          return Container();
                        }),
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context)
                        .push(
                        MaterialPageRoute(
                            builder: (BuildContext
                            context) => userPannel(dates: date,products: products,product_name: product_name,listofvalues:listofvalues)));

                  }, child: Text("Add")),
                ],
              ),
            ),

          ],
        )):  TextButton(onPressed: (){
      Navigator.of(context)
          .push(
          MaterialPageRoute(
              builder: (BuildContext
              context) => userPannel(dates: date,products: products,product_name: product_name,)));

    }, child: Text("Add"));
  }

  build_weekly_orders(List<String>? date,
      List<DocumentSnapshot<Object?>>? products, int tomorrow, List<String> product_name, List? listofvalues, String? singledate) {

     print(listofvalues);
      var get_list = authentication.getProductswithdates(products, date,singledate);
       var get_values = authentication.get_id(listofvalues);
      return Container(

      );
  }

}


