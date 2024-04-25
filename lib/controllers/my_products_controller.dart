import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore_web/src/interop/firestore.dart';

class MyProductsController extends GetxController {
  RxList <ProductModel> forsaleProductsList = <ProductModel>[].obs;
  RxList <ProductModel> soldProductsList = <ProductModel>[].obs;
  RxString tab = "For sale".obs;

  @override
  void onInit(){
    forsaleProductsList.bindStream(
      productcollection
          .where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('sold',isEqualTo: false)
          .snapshots()
          .map((QuerySnapshot query){
            List<ProductModel> products =[];
            query.docs.forEach((element) {
              products.add(ProductModel.fromDocumentSnapshot(element));
            });
            return products;
      }));
    super.onInit();
  }

  getsolditems() {
    if (soldProductsList.firstRebuild) {
      soldProductsList.bindStream(
          productcollection
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('sold', isEqualTo: true)
              .snapshots()
              .map((QuerySnapshot query) {
            List<ProductModel> products = [];
            query.docs.forEach((element) {
              products.add(ProductModel.fromDocumentSnapshot(element));
            });
            return products;
          }));
    }
  }

  changeTab(String newTab){
    tab.value =newTab;
    if (newTab=="Sold"){
      getsolditems();
    }
  }

}
