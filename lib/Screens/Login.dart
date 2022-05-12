import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalluri_milk/Screens/WaveClipper.dart';
import 'package:kalluri_milk/repositories/authentication.dart';
import '../AdminScreens/homeScreen.dart';
import '../UserScreens/userhomescreen.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final form_key = GlobalKey<FormState>();
  bool? pressed = false;
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WaveClipper(),
          SizedBox(
            height: 30,
          ),
          Form(
            key: form_key,
            child: Container(
              padding: EdgeInsets.all(20.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  PhoneNumberField(),
                  pressed!
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           SizedBox(height: 25,),
                            otpField(),
                            SizedBox(height: 10,)
                          ],
                        )
                      : Container(),
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 7.3),
                          child: pressed == false
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(60, 40),
                                      primary: Color(0xcc167e43),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    setState(() {
                                      pressed = true;
                                    });
                                  },
                                  child: Text(
                                    "Send Otp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Poppins-Light"),
                                  ))
                              : SizedBox(
                                width: MediaQuery.of(context).size.width*0.40,
                                height: 45,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 2.3,
                                        primary: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25))),
                                    onPressed: () {
                                      setState(() {
                                    var validate = form_key.currentState!.validate();
                                    var auth;
                                        if (validate) {
                                          FirebaseAuth.instance.signInAnonymously().then((UserCredential user){
                                            auth = authentication.adminAuthentication(phoneController.text,otpController.text);
                                            print(auth);
                                            auth == "admin"
                                                ? Navigator.of(context)
                                                .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        adminPannel(phonenumber:phoneController.text)))
                                                :auth=="Valid"? Navigator.of(context)
                                                .push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        userPannel(phoneNumber:phoneController.text))):Navigator.of(context)
                                                .push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        Login()));
                                          });

                                        }


                                      });
                                    },
                                    child: Text("Login",
                                          style: TextStyle(
                                             color: Colors.white,
                                             fontFamily: "Poppins-Medium",
                                             fontSize: 18),
                                    )
                                ),
                              )
                      ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  PhoneNumberField() {
    return SizedBox(
      height:55,
      child: TextFormField(
        validator: (phoneNumber) {
          if (phoneNumber!.isEmpty) {
            return 'Please enter Phonenumber';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mobile_friendly_outlined,color: Colors.lightBlueAccent),
            hintText: "Enter phone number",
            labelText: "Phone number",
            labelStyle: const TextStyle(color: Color(0xff576630),fontSize: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8FCC20), width: 1.7),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: phoneController,
        cursorColor: Colors.orange,
        style: const TextStyle(
            color: Color(0xff394028),
            fontSize: 15,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins-Light"),
      ),
    );
  }

  otpField() {
    return SizedBox(
      height: 55,
      child: TextFormField(
        validator: (otpNumber) {
          if (otpNumber!.isEmpty) {
            return 'Please enter Otp';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Enter Otp",
            labelText: "Otp number",
            labelStyle: const TextStyle(color: Color(0xcc576630),fontSize: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8FCC20), width: 1.6),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: otpController,
        cursorColor: Colors.deepPurple,
        style:  TextStyle(
            color: Colors.deepPurple, fontSize: 17,letterSpacing: 1.0,),
      ),
    );
  }
}
