import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/repositories/authentication.dart';
import 'package:kalluri_milk/UserScreens/add_products.dart';
class productsPage extends StatefulWidget {
  String? phoneNumber;
  List<String>? date =[];
  List<DocumentSnapshot>? products;
  productsPage({this.phoneNumber, this.date,this.products });
  @override
  productsPageState createState() =>
      productsPageState(phoneNumber: this.phoneNumber);
}

class productsPageState extends State<productsPage> {
  var collection;
  String? phoneNumber;
  Authentication authentication = Authentication();

  var optioncategory;

  productsPageState({this.phoneNumber});
  bool pressed = true;
  int? index = 0;
  String? productCategory  = "Milk";
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .snapshots();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        padding: EdgeInsets.all(10.8),
        child: StreamBuilder<QuerySnapshot>(
            stream: collection,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot<Object?>? userData = snapshot.data;
                List categories = authentication.get_categories(userData);
                Iterable products = categories.reversed;
                categories = products.toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 65,
                      child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, count) {
                            productCategory = categories[0];
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.6),
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildCategoriesButton(categories, count)
                              ],
                            ));
                          }),
                    ),
                    build_sub_products(productCategory,userData)
                  ],
                );
              }
              return Container();
            }));
  }

  build_sub_products(String? productCategory, QuerySnapshot<Object?>? userData,) {
    return Expanded(child: ListView.builder(
        itemCount: userData!.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          print(productCategory);
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
                    elevation: 2.3,
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
                        build_buttons(userData, id),
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
  buildCategoriesButton(List categories,int count) {
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(right: 25.6),
            child: TextButton(
              onPressed: () {
                setState(() {
                  productCategory =
                  categories[count];
                  print(productCategory);
                  index = count;
                });
              },
              child: Text(
                categories[count],
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins-Light",
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              style: ButtonStyle(
                  minimumSize:
                  MaterialStateProperty.all(
                      Size(80, 0)),
                  shape: count == index
                      ? MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                              20.0),
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
                      Colors.grey.shade100),
                  foregroundColor:
                  MaterialStateProperty.all(
                      Colors.white)),
            ),
          ),
        ],
      ),
    );
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

  build_buttons(QuerySnapshot<Object?> userData, String id) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 100,),
        SafeArea(
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 13.3),
            child: TextButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(80, 20)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(
                        builder: (BuildContext
                        context) =>
                            addProducts(id:id,phoneNumber:phoneNumber, datesOfCalender:widget.date,products:widget.products)));
              },
              child: Container(
                
                  child: Text("Add",style: TextStyle(color: Colors.black,fontFamily:"Poppins-Medium",fontSize: 15),)),
            ),
          ),
        ),
        SafeArea(
          child: Container(
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
          ),
        ),
      ],
    );
  }


}
