import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

import 'add_products.dart';

class productsPage extends StatefulWidget {
  List<String>? date;
  String? phonenumber;
  List<String>?product_name;
  bool?firstClick;
  String?buttonselect;
  List<DocumentSnapshot>?products;
  List? listofvalues;
  productsPage({
    this.phonenumber,
    this.date,this.products,
    this.firstClick,
    this.buttonselect,
    this.product_name,
    this.listofvalues,
  });

  @override
  _productsPageState createState() {
    return _productsPageState(phonenumber: phonenumber, date: this.date,products:this.products,product_name:this.product_name,listofvalues:listofvalues);
  }
}

class _productsPageState extends State<productsPage> {
  List<String>? date;
  String? phonenumber;
  var collection;
  String?buttonselect;
  List<DocumentSnapshot>?products;
  List<DocumentSnapshot>?items;
  String? selected;
  List? listofvalues;
  List<String>?product_name;
  _productsPageState({this.phonenumber, this.date,this.products,this.product_name,this.listofvalues });
  bool? pressed = true;
  bool?firstclick =false;
  int? index = 0;
  String? productCategory = "Milk";
  Authentication authentication = Authentication();
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .snapshots();
    if(product_name==null){
      product_name =[];
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print(products);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: collection,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot<Object?>? userData = snapshot.data;
                  List categories = authentication.get_categories(userData);
                  Iterable products = categories.reversed;
                  categories = products.toList();
                  print(userData!.docs[0].data());
                  var height = MediaQuery.of(context).size.height/12;
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height:height,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, count) {
                              productCategory = categories[0];
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildCategoriesButton(categories, count),
                                    
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        build_products(productCategory,userData,date,product_name)
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              })
        ],
      ),
    ));
  }
  buildCategoriesButton(List categories,int count) {
    return  Column(
      children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(right: 25.6),
            child: TextButton(
              onPressed: () {
                setState(() {
                  productCategory = categories[count];

                  index = count;
                });
              },
              child: Text(categories[count],
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins-Light",
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(80, 0)),
                  shape: count == index ?
                  MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            color: Colors.white,
                          )))
                      : MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        side:
                        BorderSide.none),
                  ),
                  backgroundColor: count == index
                      ? MaterialStateProperty.all(
                      Colors.white)
                      : MaterialStateProperty.all(
                      Colors.grey.shade50),
                  foregroundColor:
                  MaterialStateProperty.all(
                      Colors.white)),
            ),
          ),

        ],
      ),

    ]
    );
  }

  build_products(String? productCategory, QuerySnapshot<Object?>? userData, List<String>? date,List<String>? product_name) {
    print(product_name);
    return Expanded(child: ListView.builder(
          itemCount: userData!.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {

            DocumentSnapshot product = userData.docs[index];
            String sub_categories = product.get("category");
            var id = product.id;
            if (productCategory == sub_categories) {
              var units = productCategory == "Milk" ? "Ml" : "Gms";
              return Column(
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.40,
                    child:Card(
                      elevation: 3.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              build_image(product),
                              Container(
                                margin:EdgeInsets.only(left: 5.3),
                              ),
                              build_data(product, units)
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 100,),
                              SafeArea(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 13.3),
                                  child:product_name!.contains(product.get("productName"))?Container(child:Text("Already added",style: TextStyle(color: Colors.red),),):TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color(0xfff1d799)),
                                      minimumSize: MaterialStateProperty.all(Size(80, 20)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                          )
                                      ),
                                    ),
                                    onPressed: () {
                                      var dates = date;
                                      setState(() {

                                        product_name.add( product.get("productName"));
                                        Navigator.of(context)
                                            .push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                context) => add_products(date: dates,id:id,products: products,product_name:product_name,listOfvalues: listofvalues,)));
                                      });
                                    },
                                    child: Container(

                                        child: Text("Add",style: TextStyle(color: Colors.black,fontFamily:"Poppins-Medium",fontSize: 15),)),
                                  ),
                                )
                              ),
                              SafeArea(
                                child:Container(
                                  child: TextButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(Size(80, 20)),
                                      backgroundColor: MaterialStateProperty.all(Color(0xfff2d695)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          )
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(left: 15.3,right: 15.3),
                                        child: Text("Subscribe",style: TextStyle(color: Colors.black54,fontFamily:"Poppins-Medium",fontSize: 16),)),
                                  ),
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.3),
                  )
                ],
              );
            }
            return Container();
          }
      ));

  }

  build_image(DocumentSnapshot<Object?> product) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 10.6,right: 2.6),
      child: Column(
        children: [
          SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300.withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: product.get("image"),
              width: 120,
            ),
          ),
        ],
      ),
    );
  }

  build_data(DocumentSnapshot<Object?> product, String units) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(12.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Container(
            child: Text(
              "Kalluri".toUpperCase(),
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: "Poppins-Light",
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
            ),
            margin: EdgeInsets.only(bottom: 3.3),
          ),

          Container(
            child: Text(
                product.get("productName"),
                style: TextStyle(fontSize:17,fontFamily: "Poppins-Medium")
            ),
            margin: EdgeInsets.only(bottom: 5.3),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.6, bottom: 6.3),
            child:
            Text(product.get("quantity").toString() + " " + units + " Pouch"),
          ),
          Container(
              margin: EdgeInsets.only(top: 2.6, bottom: 8.3),
              child: Text("₹  " + product.get("price").toString() + ".00", style: TextStyle(fontSize:18,fontFamily: "Poppins-Medium"),)),
        ],
      ),
    );
  }

}
