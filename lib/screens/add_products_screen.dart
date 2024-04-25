import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:get/get.dart';
import 'package:mustexchange/screens/addproduct/title_screen.dart';
import 'package:mustexchange/controllers/bindings/add_product_binding.dart';

class AddProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(left: 25, top:50,),
              child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Sell an item",
                  style: myStyle(25, Colors.black, FontWeight.w600),
                  )
              )
            ),
            Padding(
              padding: EdgeInsets.only(
                  top:MediaQuery.of(context).size.height*0.5-150),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Want to sell something?, \nadd here",
                  style: myStyle(18, Colors.grey, FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: ()=>Get.to(()=>TitleScreen(),binding: AddProductBinding()),
                  child: Container(
                  width: MediaQuery. of (context).size.width,
                  margin: EdgeInsets.only(left: 23, right: 23),
                  decoration: BoxDecoration (
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center (
                        child: Text (
                          "Sell my items",
                          style: myStyle (15, Colors.white, FontWeight.w600),
                        ),
                      ),
                  ),
                ),
                ),
                ],
            ),
            ),
            ],
      ),
    ),
    );
  }
}