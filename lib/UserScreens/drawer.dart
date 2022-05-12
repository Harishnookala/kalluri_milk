import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';
import 'package:kalluri_milk/UserScreens/yourorders.dart';
class build_drawer extends StatefulWidget {
  String?phoneNumber;
   build_drawer({Key? key,
    this.phoneNumber,
   }) : super(key: key);

  @override
  _build_drawerState createState() => _build_drawerState(
    phoneNumber:this.phoneNumber
  );
}

class _build_drawerState extends State<build_drawer> {
  String?phoneNumber;
  _build_drawerState({this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(child: Text("Phonenumber : -  " + phoneNumber.toString())),

              Container(

                child: Row(
                  children: [
                    Icon(Icons.shopping_bag,color: Colors.orangeAccent,),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Yourorders(phoneNumber: phoneNumber,)));
                       }, child: Text("Your Orders",style: TextStyle(color: Colors.lightBlueAccent,fontFamily: "Poppins"),)),
                  ],
                ),
              ),


        ],
      ),
      
    );
  }
}
