import 'package:mustexchange/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mustexchange/services/database.dart';
import 'package:mustexchange/utils/models/contact_model.dart';
import 'package:mustexchange/utils/models/user_model.dart';


class Message {
  late String messageid;
  late String senderid;
  late String recieveruid;
  late String message;
  late DateTime time;
  late bool sentByMe;

  Message(this.messageid,this.senderid, this.recieveruid, this.message,
      this.time,this.sentByMe);
  Message.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc){
    messageid = doc.id;
    senderid = doc['senderid'];
    recieveruid = doc['recieveruid'];
    message = doc['message'];
    time = doc['timesent'].toDate();
    sentByMe= doc['senderid']==FirebaseAuth.instance.currentUser!.uid;

  }
}
