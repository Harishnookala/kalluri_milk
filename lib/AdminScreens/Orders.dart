import 'package:flutter/material.dart';
import 'package:kalluri_milk/AdminScreens/user_orders.dart';

import '../Screens/Login.dart';
import '../main_Screen.dart';
class build_admin_drawer extends StatefulWidget {
   String?phoneNumber;
   build_admin_drawer({Key? key,this.phoneNumber}) : super(key: key);

  @override
  build_admin_drawerState createState() => build_admin_drawerState(phoneNumber:this.phoneNumber);
}

class build_admin_drawerState extends State<build_admin_drawer> {
  String?phoneNumber;
  build_admin_drawerState({this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:  Text(phoneNumber!),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  build_orders()));
        }, child:Text("Users Orders")),

        SizedBox(
          width: 80,
          height: 33,
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.orange,
               elevation: 0.3,
              ),
              onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    mainScreen()));
          }, child:Container(
               alignment: Alignment.topCenter,
              child: Text("Log Out",style: TextStyle(color: Colors.white),))),
        )
      ],
    );
  }


}
