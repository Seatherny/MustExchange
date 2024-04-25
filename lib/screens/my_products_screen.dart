import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/controllers/my_products_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:mustexchange/utils/widgets/myadd_item.dart';
import 'package:mustexchange/utils/models/product_model.dart';

class MyProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyProductsController controller=Get.put(MyProductsController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Material(
              elevation: 2,
              child: Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.19 ,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your items",
                        style: myStyle(23, Colors.black, FontWeight.w500),
                    ),
                      Spacer(),
                      Obx(() => Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: ()=> controller.changeTab("For sale") ,
                                child: Text("For sale",
                                style: myStyle(18,
                                    controller.tab.value =="For sale"
                                        ? Colors.black
                                        : Colors.grey,
                                    FontWeight.w600),
                              ),
                              ),
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: ()=> controller.changeTab("Sold") ,
                                child:Text("Sold",
                                style: myStyle(18,controller.tab.value =="Sold"
                                    ? Colors.black
                                    : Colors.grey, FontWeight.w600),
                              )),
                            ],
                          ),

                          const SizedBox(height: 6,),
                          Row(
                            children: [
                              controller.tab.value =="For sale"
                                  ? Container(
                                width: 55,
                                height: 2,
                                color: Colors.greenAccent[100],
                              ): Container(
                                width: 55,
                              ),
                              const SizedBox(width: 25,),
                              controller.tab.value =="Sold"
                                  ? Container(
                                width: 40,
                                height: 2,
                                color: Colors.greenAccent[100],
                              ): Container(
                                width: 55,
                              ),
                            ],
                          )
                        ],
                      ),
                      ),
                  ],
                ),
              ),
            ),
            ),

            Obx(
              ()=> controller.tab.value == "For sale"
                  ? controller.forsaleProductsList.length==0
                  ? Padding(padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/3),
                    child: Text("No items", style: myStyle(20, Colors.black, FontWeight.w500),
                      textAlign: TextAlign.center,),
                  )
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    itemCount: controller.forsaleProductsList.length,
                    itemBuilder: ((context, index) {
                    return MyAdItem(controller.forsaleProductsList[index]);
                  }),
                ) : controller.soldProductsList.length==0
                  ? Padding(padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/3),
                child: Text("No items", style: myStyle(20, Colors.black, FontWeight.w500),
                  textAlign: TextAlign.center,),
              )
              : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    itemCount: controller.soldProductsList.length,
                    itemBuilder: ((context, index) {
                      return MyAdItem(controller.soldProductsList[index]);
                    }),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

