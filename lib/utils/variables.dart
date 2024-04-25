import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


TextStyle myStyle(double size, Color color, FontWeight fw){
  return GoogleFonts.montserrat(fontSize: size, fontWeight: fw, color: color);
}

CollectionReference usercollection =
FirebaseFirestore.instance.collection('users');

CollectionReference productcollection =
FirebaseFirestore.instance.collection('products');

CollectionReference reportscollection =
FirebaseFirestore.instance.collection('reports');

Reference imagesfolder =FirebaseStorage.instance.ref().child('images');
Reference profilefolder =FirebaseStorage.instance.ref().child('profilepics');

List categories= [
  "Stationary",
  "Cosmetics",
  "Jewellery",
  "Footwear",
  "Grocery",
  "Clothing",
  "Furniture",
  "Books",
  "Others",
];