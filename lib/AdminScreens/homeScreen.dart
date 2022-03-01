import 'package:flutter/material.dart';
import 'package:kalluri_milk/AdminScreens/shownProducts.dart';

import 'newproducts.dart';

//Admin Home Screen

class adminPannel extends StatefulWidget {
  @override
  adminPannelState createState() => adminPannelState();
}

class adminPannelState extends State<adminPannel> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfff0d9a1),
          leading: IconButton(
            icon: Icon(Icons.menu, size: 40), // change this size and style
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Kalluris",
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(35, 35),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                        MaterialPageRoute(
                            builder: (BuildContext
                            context) =>
                                newProducts()));
                  },
                  child: Text(" +  Create ",
                      style: TextStyle(fontFamily: "Poppins-Thin",fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
        drawer: Container(
          width: 300,
          color: Colors.white,
          child: Drawer(
              child: DrawerHeader(
            child: Text("Harish"),
          )),
        ),
        body: shownProducts(),
      ),

    );
  }
}
