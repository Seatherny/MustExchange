import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mustexchange/Authentication/login_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/controllers/auth_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MEx',
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}

class Root extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(
        (){
          return(authController.firebaseuser.value == null)
              ? Loginscreen()
              : Navigation();
        }
    );
  }
}

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
        onTap: ()=> FirebaseAuth.instance.signOut(),
        ));
  }
}

