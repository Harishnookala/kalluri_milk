import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/products.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';
import 'package:kalluri_milk/models/products.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  int?values;
  int? selectedindex=1;
   HomePage({Key? key, this.selectedindex,this.values}) : super(key: key);

  @override
  HomePageState createState() => HomePageState(values:this.values);
}

class HomePageState extends State<HomePage> {
  int?values;
  HomePageState({this.values});
  List products = ["Milk", "Ghee", "Curd", "Paneer" , "Grocery","Eggs"];
  @override
  Widget build(BuildContext context) {
    List images = [
      "assets/Images/milk.png",
      "assets/Images/curd.png",
      "assets/Images/Panner.png",
      "assets/Images/ghee.png",
      "assets/Images/Grocery.png",
      "assets/Images/Eggs.png"
    ];
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 25,),
                 Container(
                   child: Container(
                     margin: EdgeInsets.only(top: 1.6),
                     width: MediaQuery.of(context).size.width/1.2,
                     decoration: BoxDecoration(
                       border: Border.all(width: 1.9, color: Colors.black),
                       borderRadius: BorderRadius.all(Radius.circular(4.6)),
                     ),
                     child: Container(
                       margin: EdgeInsets.only(bottom: 12.3,top: 12.3),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Center(child: Image.asset("assets/Images/Cart.png",width: 60,)),
                           Container(
                             margin: EdgeInsets.only(top: 5.3,bottom: 12.3),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                     margin: EdgeInsets.only(bottom: 5.3,left: 18.3),
                                     child: values!=null?Text(values.toString(),style: TextStyle(color: Colors.black),):Text("0")),
                                 Container(
                                     margin: EdgeInsets.only(bottom: 5.3,left: 18.3),
                                     child: Text("Items in the Cart"))
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                 ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 30,),
                        Container(
                            child: Text("Popular Categories",style: TextStyle(color: Colors.black,fontSize: 15)),
                         margin: EdgeInsets.only(left: 14.3,),
                        ),
                        Row(
                          children: [
                             Container(
                               margin:EdgeInsets.only(left:MediaQuery.of(context).size.width/12.9),
                               width: MediaQuery.of(context).size.width/1.2,
                               child: GridView.count(
                                    crossAxisCount: 3,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    childAspectRatio: 1.8/2.0,
                                    children: List.generate(products.length, (index) {
                                      return Container(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                             primary: Colors.white
                                           ),
                                          onPressed: () {
                                            setState(() {
                                              var productCategory = products[index];
                                              print(productCategory);
                                            });
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: SizedBox(
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                               Expanded(
                                                                 child: Container(
                                                                  child: Image.asset(
                                                                    images[index],
                                                                    width: 120,
                                                                  ),
                                                              ),
                                                               ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                Container(
                                                  margin: EdgeInsets.only(top: 3.3),
                                                  alignment: Alignment.center,
                                                    child: Text(
                                                  products[index].toString().toUpperCase(),
                                                  style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: "Poppins-Light"),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                             ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
