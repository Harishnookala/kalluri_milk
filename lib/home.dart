import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget{
  @override
  HomeState createState() =>HomeState();

}

class HomeState extends State<HomeScreen>{
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xfff0d9a1),
          leading: IconButton(
            icon: Icon(Icons.menu, size: 40), // change this size and style
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: Row(
            children: [
              Container(
                child: Text("Kalluri's Milk",
                  style: TextStyle(color: Colors.white,fontFamily:"Poppins",fontWeight: FontWeight.w400 ),),
              )
            ],
          ),
        ),
        drawer: Container(
          width: 300,
          color: Colors.white,
          child: Drawer(
            child: DrawerHeader(
              child: Text("Harish"),
            )
          ),
        ),
      ),
    );
  }

}