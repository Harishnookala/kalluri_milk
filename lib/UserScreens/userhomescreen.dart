import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/products_screen.dart';
import 'package:kalluri_milk/UserScreens/profile_scren.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class userPannel extends StatefulWidget {
  String? phoneNumber;
  List<String>? dates=[];
  List<DocumentSnapshot>? products;
  userPannel({this.phoneNumber,this.dates, this.products});
  @override
  userPannelState createState() =>
      userPannelState(phoneNumber: this.phoneNumber);
}

class userPannelState extends State<userPannel> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? phoneNumber;
  userPannelState({this.phoneNumber});
  int _selectedIndex = 0;
  List items =["Harish"];
  @override
  Widget build(BuildContext context) {
    print(widget.dates);
    List<Widget> tabList = <Widget>[
      HomePage(),
      productsPage(phoneNumber: phoneNumber,date: widget.dates,products:widget.products),
      WalletPage(),
      profilePage(),
    ];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade100,
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Color(0xfff0d9a1),
            leading: Container(
              margin: EdgeInsets.only(left: 3.3),
              child: IconButton(
                icon: Icon(Icons.menu, size: 40), // change this size and style
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
                      color: Color(0xff167e43),
                      fontFamily: "Poppins-Medium",
                      fontSize: 18,
                    ),
                  ),
                ),
                Stack(children: [
                  IconButton(icon:Icon( Icons.add_shopping_cart,color: Colors.lime), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> WalletPage()));

                  },),
                  (items.length>0)?Positioned(
                     right: 10,
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(items.length.toString(),style: TextStyle(color: Colors.orange),),
                        )),
                  ):Text("")
                ],),
              ],
            ),
          ),
          drawer: Container(
            width: 280,
            color: Colors.white,
            child: Drawer(
                child: DrawerHeader(
              child: Text("Harish"),
            )),
          ),
          body: tabList.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            elevation: 1.0,
            selectedItemColor: Colors.yellow.shade600,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey.shade400,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_filled),
                backgroundColor: Colors.white
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
              print(index);
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ));
  }
}
