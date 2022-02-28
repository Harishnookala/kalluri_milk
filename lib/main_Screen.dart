import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/Login.dart';

class mainScreen extends StatefulWidget {
  @override
  mainScreenState createState() => mainScreenState();
}

class mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(3.3),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),

              child: Container(
                margin: EdgeInsets.all(16.3),
                child: Image.asset(
                  "assets/Images/milk_Logo.png",

                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            child: Container(
                //margin: EdgeInsets.only(left:5.6,right: 5.6),
                height: MediaQuery.of(context).size.height / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(60, 40),
                      topRight: Radius.elliptical(60, 60)),
                  child: Container(
                    color: Color(0xfff5e2b7),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2.3,
                                primary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontFamily: "Poppins-BoldItalic"),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2.3,
                                primary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontFamily: "Poppins-BoldItalic"),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ) // This trailing comma makes auto-formatting nicer for build methods.
                ),
          )
        ],
      ),
    );
  }
}
