import 'package:flutter/material.dart';
import 'package:kalluri_milk/UserScreens/products.dart';
import 'package:kalluri_milk/UserScreens/userhomescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = ["Milk", "Ghee", "Panner", "Curd"];
  @override
  Widget build(BuildContext context) {
    List images = [
      "assets/Images/milk_product_image.jpg",
      "assets/Images/curd_image.jpg",
      "assets/Images/panner_image.jpg",
      "assets/Images/ghee_image.jpg",
    ];
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 3.0,
                      shrinkWrap: true,
                      children: List.generate(products.length, (index) {
                        return Container(
                          child: TextButton(
                            onPressed: () {

                              },
                            child: Container(
                              margin:EdgeInsets.only(left: 12.3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        images[index],
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(12.3),
                                      child: Text(products[index]))
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
    );
  }
}
