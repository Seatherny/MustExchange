import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:mustexchange/utils/variables.dart';
//import 'package:cloud_firestore_web/src/interop/firestore.dart';
import 'package:mustexchange/utils/widgets/featured_item.dart';


class HomeController extends GetxController {
  RxList<ProductModel> featuredlist =<ProductModel>[].obs;
  RxList<ProductModel> recommendedlist =<ProductModel>[].obs;

  @override
  void onInit(){
    get_featured_items();
    get_recommended_items();
    super.onInit();
  }
  get_featured_items(){
    featuredlist.bindStream(productcollection
        .where('featured', isEqualTo: true)
          .where('sold', isEqualTo: false)
          .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(15)
          .snapshots()
          .map((QuerySnapshot query){
            List<ProductModel> products =[];
            query.docs.forEach((element) {
              products.add(ProductModel.fromDocumentSnapshot(element));
            });
            return products;
      }));
  }
  get_recommended_items(){
    recommendedlist.bindStream(productcollection
      .where('sold', isEqualTo: false)
      .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .limit(10)
      .snapshots()
      .map((QuerySnapshot query){
    List<ProductModel> products =[];
    query.docs.forEach((element) {
      products.add(ProductModel.fromDocumentSnapshot(element));
    });
    return products;
  }));}
}
