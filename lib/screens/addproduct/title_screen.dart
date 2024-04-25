import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/controllers/add_product_controller.dart';
import 'package:get/get.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:mustexchange/screens/addproduct/photos_screen.dart';

class TitleScreen extends StatelessWidget {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: additemappbar,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        child:
        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 28,),
        onPressed: ()=> Get.to(()=>PhotosScreen(
          ProductModel(
              title: titlecontroller.text,
              description: descriptioncontroller.text,)
        )),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right:5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What type of item is it?", style:
              myStyle(20, Colors.grey, FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GetBuilder<AddProductController>(
                init: AddProductController(),
                builder: (controller) {
                  return Wrap(
                    spacing: 3,
                    children: categories
                        .map(
                          (category) => InkWell(
                          onTap: ()=> controller.selectCategory(category),
                          child:Chip(
                            padding: EdgeInsets.zero,
                            backgroundColor: controller.category==category
                                 ?Colors.pinkAccent
                                : Colors.indigoAccent,
                            label: Text(
                              category,
                              style: myStyle(15, Colors.white, FontWeight.w600),
                            ),
                          ),
                    ),
                    )
                        .toList(),
                  );
                }
        ),
            SizedBox(height: 15),
              Text("Describe your product",
                style: myStyle(20, Colors.grey, FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextFormField(
                  controller: titlecontroller,
                  style: myStyle(16, Colors.black, FontWeight.w400),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: myStyle(16, Colors.black, FontWeight.w500),
                ),
              )
              ),
              SizedBox(height: 10),
              Container(
                  height: 40,
                  child: TextFormField(
                    controller: descriptioncontroller,
                    style: myStyle(16, Colors.black, FontWeight.w400),
                    maxLines: null,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Descrption",
                      hintStyle: myStyle(16, Colors.black, FontWeight.w500),
                    ),
                  )
              ),
          ],
        ),
      ),
      ),
    );
  }
}

PreferredSizeWidget additemappbar = PreferredSize(
    preferredSize: Size.fromHeight(45), child: AppBar(
      backgroundColor: Colors.indigoAccent, automaticallyImplyLeading: false,
        title: Text("Add an item to sell",
      style: myStyle(20, Colors.white, FontWeight.w700),
),
)
);