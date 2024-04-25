import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? profilepic;
  String? username;
  String? city;
  String? country;
  String? street;
  String? phone;
  double? lat;
  double? lon;
  Timestamp? createdAt;

  UserModel(
      {this.uid,
        this.profilepic,
        this.username,
        this.city,
        this.country,
        this.street,
        this.lat,
        this.lon,
        this.phone,
        this.createdAt });

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Object?> doc){
    uid = doc.id;
    profilepic = doc['profilepic'];
    username = doc['name'];
    city = doc ['city'];
    country = doc['country'];
    street = doc['street'];
    phone = doc['phone'];
    lat = doc['lat'];
    lon = doc ['lon'];
    createdAt = doc['date'];
  }
  }
