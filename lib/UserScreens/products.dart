import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/models/products.dart';
import 'package:kalluri_milk/repositories/authentication.dart';

import 'add_products.dart';

class productsPage extends StatefulWidget {
  List<String>? date;
  int?items;
  String? phonenumber;
  List<String>?product_name;
  String?productCategory;
  bool?firstClick;
  String?buttonselect;
  DocumentSnapshot? products;
  List? listofvalues;
  List?listofproduct_items;
  List? listOfWeekdays;
  List? listofpackets;
  int?count;
  List<DocumentSnapshot?>? listofproducts;

  productsPage( {

    this.phonenumber,
    this.date,
    this.products,
    this.firstClick,
    this.buttonselect,
    this.product_name,
    this.listofvalues,
    this.items,
    this.listofproduct_items,
    this.listofpackets,
    this.listofproducts,
    this.listOfWeekdays,
    this.productCategory,
    this.count,
  });

  @override
  _productsPageState createState() {
    return _productsPageState(phonenumber: phonenumber, date: this.date,products:this.products,
        product_name:this.product_name,
        listofvalues:this.listofvalues,
        product_items:this.items,
      listofproduct_items:this.listofproduct_items,
        listOfWeekdays:this.listOfWeekdays,
      listofproducts:this.listofproducts,
      listofpackets:this.listofpackets,
      productCategory:this.productCategory,
        index:this.count
    );
  }
}

class _productsPageState extends State<productsPage> {
  List<String>? date;
  String? phonenumber;
  var collection;
  int? product_items;
  String?buttonselect;
  List? listOfWeekdays;
  List? listofpackets;
  List<DocumentSnapshot?>? listofproducts;
  DocumentSnapshot?products;
  List<DocumentSnapshot>?items;
  String? selected;
  List? listofvalues;
  List?listofproduct_items;
  List<String>?product_name;
  _productsPageState({this.phonenumber, this.date,this.products,this.product_name,
    this.listofvalues,this.product_items,this.listofproduct_items,this.listofpackets,this.listofproducts,this.listOfWeekdays,this.productCategory,this.index});
  bool? pressed = true;
  bool?firstclick =false;
  int? index;
  String? productCategory;
  Authentication authentication = Authentication();
  @override
  void initState() {
    collection =  FirebaseFirestore.instance
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
     print(productCategory);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
        body: Container(
      padding: EdgeInsets.all(12.0),
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
    if(index ==null){
      index = 0;
    }
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
              child: Text(categories[count].toString().toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins-Light",
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(count==index?0.9:0.0),
                  minimumSize: MaterialStateProperty.all(Size(80, 30)),
                  shape:MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: count==index?BorderSide(
                            color: Colors.white,
                          ):BorderSide.none)),
                  backgroundColor: count == index
                      ? MaterialStateProperty.all(
                      Colors.white)
                      : MaterialStateProperty.all(Colors.grey.shade100),
                  ))
            ),


        ],
      ),

    ]
    );
  }

  build_products(String? productCategory, QuerySnapshot<Object?>? userData, List<String>? date,List<String>? product_name) {
   if(productCategory==null){
      productCategory = "Milk";
    }

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
                    child:Card(
                      elevation: 2.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: SizedBox(
                                  width: 80,
                                  height: 50,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(right: 13.3),
                                    child:product_name!.contains(product.get("productName"))?Container(child:Text("Already added",style: TextStyle(color: Colors.red),),):TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xccb0d44c)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            )
                                        ),
                                      ),
                                      onPressed: () {
                                        var dates = date;
                                        setState(() {
                                        product_name.add(product.get("productName"));
                                          Navigator.of(context)
                                              .push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                  context) => add_products(date: dates,id:id,products: products,
                                                    product_name:product_name,
                                                    listOfvalues: listofvalues,
                                                      product_items:product_items,listofproduct_items:listofproduct_items,
                                                      listOfWeekdays:listOfWeekdays,
                                                      listofproducts: listofproducts,
                                                       listofpackets:listofpackets,
                                                       phonenumber:phonenumber,
                                                  )));
                                        });
                                      },
                                      child: Container(
                                          child: Text("Add",style: TextStyle(color: Colors.black,fontFamily:"Poppins-Light",fontSize: 16,fontWeight: FontWeight.w500),)),
                                    ),
                                  ),
                                )
                              ),
                              SafeArea(
                                child:Container(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width/2.9,
                                    height: 40,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xccb0d44c)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            )
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                context) => add_products(date: date,id:id,products: products,product_name:product_name,
                                                    listOfvalues: listofvalues,
                                                    product_items:product_items,listofproduct_items:listofproduct_items,
                                                    listOfWeekdays:listOfWeekdays,
                                                    listofproducts: listofproducts,
                                                    listofpackets:listofpackets,
                                                    phonenumber:phonenumber
                                                )));
                                      },
                                      child: Container(

                                        alignment: Alignment.center,
                                          margin: EdgeInsets.only(left:6.3,right: 1.3),
                                          child: Text("Subscribe",style: TextStyle(color: Colors.black,
                                              fontFamily:"Poppins-Light",fontSize: 16,fontWeight: FontWeight.w500),)),
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.3,bottom: 16.3),
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
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 13.6,right: 8.6),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade50,

                 // changes position of shadow
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(top:12.3),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height/8.9,
                imageUrl: product.get("image"),
                width: MediaQuery.of(context).size.width/3,
              ),
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
                  color: Colors.grey,
                  fontFamily: "Poppins-Medium",
                  fontSize: 15,

              ),
            ),
            margin: EdgeInsets.only(bottom: 3.3),
          ),

          Container(
            child: Text(
                product.get("productName"),
                style: TextStyle(fontFamily: "Poppins-Medium")
            ),
            margin: EdgeInsets.only(bottom: 5.3),
          ),
          Container(
            width: 65,
            margin: EdgeInsets.only(top: 3.6, bottom: 6.3),
            child: Text(product.get("quantity").toString() + " " + units + " Pouch",style: TextStyle(color: Colors.grey.shade600),),
          ),
          Container(
              margin: EdgeInsets.only(top: 2.6),
              child: Text("₹  " + product.get("price").toString() + ".00", style: TextStyle(fontSize:14,fontFamily: "Poppins-Medium"),)),
        ],
      ),
    );
  }

}
