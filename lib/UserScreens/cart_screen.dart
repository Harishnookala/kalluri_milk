import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';

// ignore: must_be_immutable
class WalletPage extends StatefulWidget {
  List<String>? date;
  int? value;
  List<DocumentSnapshot>? products;
  WalletPage({this.date,this.value,this.products,});
  @override
  WalletPageState createState() {
    return WalletPageState(date:this.date,value:this.value,products:this.products);
  }
}

class WalletPageState extends State<WalletPage> {
 List<String>?date;
 int?value;
 List<DocumentSnapshot>? products;
 WalletPageState({this.date,this.value,this.products});
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:Color(0xfff1d799),
            bottom: TabBar(
              tabs: [
                 Container(
                     margin: EdgeInsets.all(13.3),
                     child: Text("Tomorrow's Order",style: TextStyle(color: Colors.black,))),
                  Container(child: Text("Week Order",style: TextStyle(color: Colors.black,)))
              ],
            ),
            title: Text('My Basket',style: TextStyle(color: Colors.black,)),
          ),
          body: TabBarView(
            children: [
              build_today_orders(date,products),
              build_weekly_orders()

            ],
          ),
        ));
  }


  build_weekly_orders(){
    return Container();
  }



  List? get_dates(List? date) {
    Set dates = HashSet();
    for(int i=0;i<date!.length;i++){
     var selected_date = date[i];
     dates.add(selected_date);
    }
    return dates.toList();
  }

  build_today_orders( List<String>? date,   List<DocumentSnapshot>? products) {
    List? dates = get_dates(date);
    print(dates);

    return Container(
      margin: EdgeInsets.only(top: 12.3),
      child: TextButton(child: Text("Add"),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            userPannel(dates:date,products:products)));
      }),
    );
  }


}
