import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:get/get.dart';
import 'package:mustexchange/controllers/auth_controller.dart';
import 'package:mustexchange/Authentication/login_screen.dart';

class RegisterScreen extends GetWidget<AuthController> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Sign up",style: myStyle(20, Colors.black, FontWeight.w700),
        ),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,), // SizedBox
              Text(
               "Register",
               style: myStyle (35, Colors.black, FontWeight.w700),
              ),
              const SizedBox(height: 10,), // Sized Box
             Text(
                 "Get ready for buying and selling",
               style: myStyle (20, Colors.grey, FontWeight.bold),
             ),
            const SizedBox(height: 50,), // Sized Box
            Row(
              children: [
                Container(
                  width: MediaQuery. of (context).size.width * 0.45,
                  margin: EdgeInsets. only (left: 20),
                  child: TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    style: myStyle(20, Colors.black, FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: myStyle (20, Colors.black, FontWeight.w600),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    // TextFormField
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  width: MediaQuery. of (context).size.width * 0.45,
                  margin: EdgeInsets.only (right: 10),
                  child: TextFormField(
                    controller: passwordcontroller,
                    keyboardType: TextInputType.emailAddress,
                    style: myStyle(20, Colors.black, FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: myStyle (20, Colors.black, FontWeight.w600),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                ],
            ),
                const SizedBox(height: 20,),

                Container(
                  width: MediaQuery. of (context).size.width ,
                  margin: EdgeInsets. only (left:20,right: 20),
                  child: TextFormField(
                    controller: usernamecontroller,
                    keyboardType: TextInputType.emailAddress,
                    style: myStyle(20, Colors.black, FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: myStyle (20, Colors.black, FontWeight.w600),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),

                const SizedBox(height: 30,),

                Container(
                  width: MediaQuery. of (context).size.width ,
                  margin: EdgeInsets. only (left:20,right: 20),
                  child: TextFormField(
                    controller: phonecontroller,
                    keyboardType: TextInputType.phone,
                    style: myStyle(20, Colors.black, FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Phone number",
                        labelStyle: myStyle (20, Colors.black, FontWeight.w600),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),

                SizedBox(height: 35,), // Center
                Obx(
                    ()=> InkWell(
                      onTap: ()=> controller.getlocation(),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.5,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.indigoAccent), // Box Decoration
                        child: Center(
                          child: Text(
                            controller.latitude.value == ""
                                ?  "Get my address"
                                : "${controller.city.value}, ${controller.country.value}",
                            style: myStyle (18, Colors.white, FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                ),

                SizedBox(height: 20,),
                InkWell(
                  onTap: ()=> controller.createuser(
                      emailcontroller.text,
                      passwordcontroller.text,
                      usernamecontroller.text,
                      phonecontroller.text),
                  child: Container(
                      width: MediaQuery.of(context).size.width /2,
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlueAccent
                      ),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: myStyle(20, Colors.white, FontWeight.w700),
                          ),
                      ),
                    )
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By signing up, you agree to our",
                      style: myStyle(16, Colors.black, FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Text(
                        "policy",
                        style: myStyle(16, Colors.indigo, FontWeight.w700),
                      ),
                    ),
            ],
        ),
    ],
    ),
        ),
      ),
    );
  }
}