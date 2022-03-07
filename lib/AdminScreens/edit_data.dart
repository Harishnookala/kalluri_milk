import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class editData extends StatefulWidget {
  String? name;
  String? category;
  int? price;
  int? quantity;
  String? image;
  String?id;
  editData({this.name, this.category, this.price, this.quantity, this.image, this.id});
  @override
  editDataState createState() {
    return editDataState(
      id:this.id,
        name: this.name,
        category: this.category,
        price: this.price,
        quantity: this.quantity,
        image: this.image);
  }
}

class editDataState extends State<editData> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? quantityController;
  String? id;
  String? name;
  String? category;
  int? price;
  int? quantity;
  String? image;
  List Category = ['Milk', 'Curd', 'Ghee', 'Paneer'];
  String? Selecteditem;
  var unSelecteditem;
  editDataState(
      {this.id,this.name, this.category, this.price, this.quantity, this.image});
  @override
  void initState() {
    nameController = TextEditingController();
    nameController!.text = name!;
    priceController = TextEditingController();
    priceController!.text = price.toString();
    quantityController = TextEditingController();
    quantityController!.text = quantity.toString();
    Selecteditem = category;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController!.dispose();
    priceController!.dispose();
    quantityController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 19.6),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
                color: Colors.greenAccent,
              ),
            ),
          ),
          Expanded(
              child: Form(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20.6, right: 20.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Product Name",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "Poppins-Light"),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    build_productName(),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      child: Text(
                        "Product Category",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "Poppins-Light"),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    updateCategories(category),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      child: Text(
                        "Price",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "Poppins-Light"),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    build_price(),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "Poppins-Light"),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    build_quantity(),
                    SizedBox(height: 10,),
                    build_button()
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  build_productName() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (name) {
          if (name!.isEmpty) {
            return 'Please enter product name';
          }
          return null;
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
            hintText: "Enter Product Name",
            labelText: "Name",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: nameController,
      ),
    );
  }

  updateCategories(String? category) {
    unSelecteditem = category;
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.black, fontFamily: "Poppins-Light"),
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade700, width: 1.5),
        ),
        contentPadding: EdgeInsets.zero,
      ),
      hint: Text(
        Selecteditem!,
        style: TextStyle(fontFamily: "Poppins-Light", color: Colors.black),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
      ),
      iconSize: 20,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      items: Category.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () {
              setState(() {
                Selecteditem = item;
              });
              Selecteditem = item;
            },
          )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select category.';
        }
      },
      onChanged: (value) {
        setState(() {});
      },
      onSaved: (value) {
        Selecteditem = Selecteditem;
        print(Selecteditem);
        value = Selecteditem;
      },
    );
  }

  build_price() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (price) {
          if (price!.isEmpty) {
            return 'Please enter price';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Enter Price",
            labelText: "Price",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: priceController,
      ),
    );
  }

  build_quantity() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (quantity) {
          if (quantity!.isEmpty) {
            return 'Please enter Quantity';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "How much Quantity",
            labelText: "Quantity",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: quantityController,
      ),
    );
  }

  build_button() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(120, 40)),
            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ))),
        child: Text(
          "Update",
          style: TextStyle(color: Colors.white, fontFamily: "Poppins-Medium"),
        ),
        onPressed: ()  async {

            print(Selecteditem);
            Selecteditem = Selecteditem;

            Map<String, dynamic> data = {
              "productName": nameController!.text,
              "category": Selecteditem,
              "price": int.parse(priceController!.text),
              "quantity": int.parse(quantityController!.text)
            };
           print(nameController!.text);
            DocumentReference documentReference =  FirebaseFirestore.instance.collection("Admin").
            doc("Products").collection("Product_details").doc(id);
              await documentReference.update(data);
            Navigator.of(context)
                .push(
                MaterialPageRoute(
                    builder: (BuildContext
                    context) =>
                        adminPannel()));

        },
      ),
    );
  }
}
