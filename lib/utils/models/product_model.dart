import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? useruid;
  List? images;
  String? title;
  double? price;
  String? category;
  Timestamp? date;
  String? description;
  bool? featured;
  bool? sold;

  ProductModel({
    this.id,
    this.useruid,
    this.images,
    this.title,
    this.price,
    this.category,
    this.date,
    this.description,
    this.featured,
    this.sold,
  }
      );


  ProductModel.fromDocumentSnapshot (QueryDocumentSnapshot<Object?> doc) {
  //id = doc['id'];
  useruid = doc['uid'];
  images = doc['images'];
  title = doc['title'];
  price = doc['price'];
  category = doc['category'];
  date = doc['date'];
  description = doc['description'];
  featured = doc['featured'];
  sold = doc['sold'];
  }
}
