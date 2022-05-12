import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/profile.dart';

import 'drawer.dart';
import 'home.dart';
import 'products.dart';
import 'wallets.dart';


class userPannel extends StatefulWidget {
  String? phoneNumber;
  List<String>? dates;
  DocumentSnapshot? products;
  List<String>?product_name;
  List? listofvalues;
  int? items;
  List?listofproduct_items;
  int?values;
  List?listOfWeekdays;
  List?listofpackets;
  List<DocumentSnapshot?>?listofproducts;
  userPannel({this.phoneNumber,this.dates, this.products, this.product_name,this.listofvalues,
    this.items,this.listofproduct_items,this.values,this.listOfWeekdays,this.listofpackets,this.listofproducts });
  @override
  userPannelState createState() =>
      userPannelState(phoneNumber: this.phoneNumber,listofvalues:listofvalues,values:values);
}

class userPannelState extends State<userPannel> with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? phoneNumber;
  userPannelState({this.phoneNumber,this.listofvalues,this.values});
  int _selectedIndex = 0;
  List items =["Harish"];
  List?listofvalues;
  int?values;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabList;
     tabList = <Widget>[
      HomePage(values:values,),
      productsPage(phonenumber:phoneNumber,date: widget.dates, products:widget.products,
          product_name:widget.product_name,listofvalues:widget.listofvalues,items:widget.items,
          listofproduct_items:widget.listofproduct_items,
          listOfWeekdays:widget.listOfWeekdays,listofproducts:widget.listofproducts,listofpackets:widget.listofpackets),
      WalletPage(
          product_name:widget.product_name,listofvalues:widget.listofvalues,listofproduct_items:widget.listofproduct_items,
        listofpackets: widget.listofpackets,listofproducts: widget.listofproducts,listOfWeekdays: widget.listOfWeekdays,
       phonenumber:widget.phoneNumber,
      ),
      profilePage(),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 2.0,
              backgroundColor: Colors.white,
              leading: Container(
                margin: EdgeInsets.only(left: 3.3),
                child: IconButton(
                  icon: Icon(Icons.menu, size: 40,color: Colors.black45,), // change this size and style
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Kalluris Farm",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins-Light",
                         fontSize: 16
                      ),
                    ),
                  ),
                  Stack(children: [
                    IconButton(icon:Icon( Icons.add_shopping_cart,color: Colors.lime), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WalletPage()));

                    },),
                    (values!=null)?Positioned(
                      right: 15,
                      top: 2,
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text(values.toString(),style: TextStyle(color: Colors.orange,fontSize: 14),),
                          )),
                    ):Text("0")
                  ],),
                ],
              ),
            ),
            drawer: Container(
              width: 280,
              color: Colors.white,
              child: Drawer(
                  child: DrawerHeader(
                    child: build_drawer(phoneNumber:phoneNumber)
                  )),
            ),
            body: Container(
              child: tabList.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              elevation: 15.3,
              selectedItemColor: Colors.green,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey.shade400,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined),
                ),
                BottomNavigationBarItem(
                  label: 'Products',
                  icon: Icon(Icons.store),
                ),
                BottomNavigationBarItem(
                  label: 'Wallet',
                  icon: Icon(Icons.account_balance_wallet_outlined),
                ),
                BottomNavigationBarItem(
                  label: 'Account',
                  icon: Icon(Icons.person),
                ),
              ],
              onTap: (index) {

                setState(() {
                  _selectedIndex = index;
                  print(_selectedIndex);

                });
              },
              type: BottomNavigationBarType.fixed,

            ),
          )),
    );
  }
}
