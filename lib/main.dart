import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:mustexchange/Authentication/login_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/controllers/auth_controller.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mustexchange/screens/chats/chats_screen.dart';
import 'package:mustexchange/screens/add_products_screen.dart';
import 'package:mustexchange/screens/home_screen.dart';
import 'package:mustexchange/screens/my_products_screen.dart';
import 'package:mustexchange/screens/Profile_screen.dart';
import 'package:mustexchange/controllers/nav_controller.dart';
import 'package:mustexchange/controllers/add_product_controller.dart';
import 'package:mustexchange/controllers/bindings/add_product_binding.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
          return(authController.firebaseuser.value == null)//null
              ? Loginscreen()
              : Navigation();
        }
    );
  }
}

class Navigation extends StatelessWidget {
  NavController navController =Get.put(NavController());
  List pages = [
    HomeScreen(),
    ChatsScreen(),//edited
    AddProductsScreen(),
    MyProductsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
          ()=> SizedBox(
            height: 88,
            child: BottomNavigationBar(
              iconSize: 25,
              selectedItemColor: Colors.blueAccent,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: myStyle(12, Colors.indigo, FontWeight.w600),
              unselectedLabelStyle: myStyle(12, Colors.black, FontWeight.w600),
              items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
              ),
              BottomNavigationBarItem( //edited
                icon: Icon(EvaIcons.messageCircleOutline),
                label: "Chats"
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.plusCircleOutline),
                label: "Sell"
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.pricetags),
                label: "My ads"
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.person),
                label: "Profile"
              ),
            ],
              currentIndex: navController.selectedindex,
              onTap: (index){
                navController.selectedindex=index;
              },
            ),
      ),
      ),
        body: Obx(()=>pages[navController.selectedindex]),

    );
  }
}

