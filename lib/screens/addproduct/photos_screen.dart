import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/screens/addproduct/title_screen.dart';
import 'package:get/get.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:mustexchange/controllers/add_product_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'dart:io';

class PhotosScreen extends StatelessWidget {
  final ProductModel product;
  PhotosScreen(this.product);
  TextEditingController pricecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: additemappbar,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        child:
        const Icon(Icons.check, color: Colors.white, size: 28,),
        onPressed: ()=> Get.find<AddProductController>().addproduct(
            ProductModel(
              title: product.title,
              description: product.description,
              price: double.parse(pricecontroller.text)
        ),
            context,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 15, right:10),
          child: GetBuilder<AddProductController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add photos",
                        style: myStyle(16, Colors.grey, FontWeight.bold),
                      ),
                      const Icon(
                          Icons.add_a_photo, size: 22, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 20),
                  controller.imageslist.isEmpty ? Center(
                    child: IconButton(
                      iconSize: 64,
                      onPressed: () => controller.pickimages(),
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  )
                      : CarouselSlider.builder(
                    itemCount: controller.imageslist.length,
                    itemBuilder: (context, index, pageview) {
                      return Image(
                          image: FileImage(
                              File(controller.imageslist[index].path)));
                    },
                    options: CarouselOptions(
                        aspectRatio: 14 / 7, autoPlay: true),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Set a price",
                    style: myStyle(16, Colors.grey, FontWeight.bold),
                  ),
                  Container(
                    height: 40,
                    child: TextFormField(
                      controller: pricecontroller,
                      style: myStyle(16, Colors.black, FontWeight.w400),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Price",
                        suffixIcon: const Icon(Icons.attach_money),
                        hintStyle: myStyle(16, Colors.black, FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              );
            },
        ),
      ),
    ),
    );
  }
}