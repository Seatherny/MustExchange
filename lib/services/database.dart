import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:uuid/uuid.dart';


class Database {
  var auth = FirebaseAuth.instance.currentUser;

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot<Object?> doc = await usercollection.doc(uid).get();
    return UserModel.fromDocumentSnapshot(doc);
  }

  Future<QuerySnapshot> getUserProducts(String uid,bool sold) async {
    QuerySnapshot query = await productcollection
        .where('uid',isEqualTo: uid)
        .where('sold',isEqualTo: sold).get();
    return query;
  }

  edituser(name,phone) async{
    await usercollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
        {'name' :name, 'phone': phone});
  }

  deleteproduct(String id) {
    productcollection.doc(id).delete();
  }
  changeStatus (bool isSold, String id) {
    productcollection.doc(id).update({"sold": !isSold});
  }

  reportuser(reporteduserid, content) async{
    await reportscollection.doc().set({
      'reprteduserid': reporteduserid,
      "user_who_reported": FirebaseAuth.instance.currentUser!.uid,
      "content": content,
      "time": DateTime.now()
    });
  }

  //chats
  sendmessage(recieveruid, message) {
    String messageid = const Uuid().v1();
    DateTime timesent = DateTime.now();
    usercollection.doc(auth!.uid).collection('chats').doc(recieveruid).set({
      'messageid': messageid,
      'lastmessage': message,
      'timesent': timesent,
    });

    usercollection
        .doc(auth!.uid)
        .collection('chats')
        .doc(recieveruid)
        .collection('messages')
        .doc(messageid)
        .set({
      'messageid': messageid,
      'senderid': auth!.uid,
      'recieveruid': recieveruid,
      'message': message,
      'timesent': DateTime.now()
    });

    usercollection.doc(recieveruid).collection('chats').doc(auth!.uid).set({
      'messageid': messageid,
      'lastmessage': message,
      'timesent': timesent,
    });

    usercollection
        .doc(recieveruid)
        .collection('chats')
        .doc(auth!.uid)
        .collection('messages')
        .doc(messageid)
        .set({
      'messageid': messageid,
      'senderid': auth!.uid,
      'recieveruid': recieveruid,
      'message': message,
      'timesent': DateTime.now()
    });
  }

  deletemessage(String id, String recieveruid) {
    usercollection
        .doc(auth!.uid)
        .collection('chats')
        .doc(recieveruid)
        .collection('messages')
        .doc(id)
        .delete();

    usercollection
        .doc(recieveruid)
        .collection('chats')
        .doc(auth!.uid)
        .collection('messages')
        .doc(id)
        .delete();
  }
}




