import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/products_screen.dart';
import 'package:kalluri_milk/UserScreens/profile_scren.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class userPannel extends StatefulWidget {
  String? phoneNumber;
  userPannel({this.phoneNumber});
  @override
  userPannelState createState() =>
      userPannelState(phoneNumber: this.phoneNumber);
}

class userPannelState extends State<userPannel> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? phoneNumber;
  userPannelState({this.phoneNumber});
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabList = <Widget>[
      HomePage(),
      productsPage(),
      walletPage(),
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
                      fontFamily: "Poppins-Light",
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
          drawer: Container(
            width: 280,
            color: Colors.white,
            child: Drawer(
                child: DrawerHeader(
              child: Text(phoneNumber!),
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
