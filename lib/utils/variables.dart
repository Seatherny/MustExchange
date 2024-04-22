import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextStyle myStyle(double size, Color color, FontWeight fw){
  return GoogleFonts.montserrat(fontSize: size, fontWeight: fw, color: color);

}

CollectionReference usercollection =
FirebaseFirestore.instance.collection('users');