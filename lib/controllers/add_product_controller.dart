import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mustexchange/utils/models/product_model.dart';

class AddProductController extends GetxController {
  String category= "Stationary";
  List<XFile> imageslist = [];
  void selectCategory(value){
    category=value;
    update();
  }

  void pickimages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    for (var element in images) {
      imageslist.add(element);
    }
    update();
  }

  addproduct(ProductModel product, context) async {
    try {
      // Dialog for showing user
      Get.defaultDialog(
          title: "uploading",
          titleStyle: myStyle(18, Colors.pink, FontWeight.w700),
          content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "We are uploading your product",
                  style: myStyle(16, Colors.grey, FontWeight.w700)
              ),
          ),
      );
      //uplaodin
      List images = [];

      for (var image in imageslist) {
        UploadTask uploadTask = imagesfolder.
        child(
            "${FirebaseAuth.instance.currentUser!.uid}-${DateTime.now()}"
        ).putFile(File(image.path));
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadurl = await snapshot.ref.getDownloadURL();
        images.add(downloadurl);
      }

      productcollection.doc().set({
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': category,
        'images': images,
        'date': DateTime.now(),
        'featured': false,
        'sold': false,
        'uid': FirebaseAuth.instance.currentUser!.uid
      });

// Going to the root screen
      int count = 0;

      Navigator.popUntil(context, (route) => count++ == 3);

      Get.snackbar("Success", "Upload was success",

          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",

          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}