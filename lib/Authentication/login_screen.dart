import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/Authentication/registerscreen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mustexchange/controllers/auth_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class Loginscreen extends GetWidget<AuthController> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Sign in",style: myStyle(20, Colors.white, FontWeight.w700),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Mody-1.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Welcome",
                style: myStyle(35, Colors.black, FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Come on in",
                style: myStyle(20, Colors.grey, FontWeight.bold),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(height: 50,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                style: myStyle(20, Colors.grey, FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: myStyle(20, Colors.blueAccent, FontWeight.w600),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              ),
              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: passwordcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: myStyle(20, Colors.grey, FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: myStyle(20, Colors.blueAccent, FontWeight.w600),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget Password ?",
                      style: myStyle(20, Colors.blueGrey,FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: ()=> controller.login(emailcontroller.text, passwordcontroller.text),
                child: Container(
                  width: MediaQuery.of(context).size.width /2,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlueAccent
                  ),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: myStyle(20, Colors.white, FontWeight.w700),
                    ),
                  ),
                ),
              ),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: myStyle(20, Colors.black, FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  InkWell(
                    onTap: ()=> Get.to(()=>RegisterScreen()),
                    child: Text(
                    "Register",
                    style: myStyle(20, Colors.indigo, FontWeight.w700),
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
