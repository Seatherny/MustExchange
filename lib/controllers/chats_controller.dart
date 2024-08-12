import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/services/database.dart';
import 'package:mustexchange/utils/models/contact_model.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  RxList<ContactModel> chatslist = <ContactModel>[].obs;

  List get chats => chatslist;

  @override
  void onInit() async {
    print("Getting chats");
    chatslist.bindStream(usercollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .map(
          (QuerySnapshot<Map<String, dynamic>> query) {
        List<ContactModel> chatusers = [];
        query.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
          chatusers.add(ContactModel(Database().getUser(doc.id),
              doc.data()['lastmessage'], doc.data()['timesent'].toDate()));
        });
        return chatusers;
      },
    ));
  }
}
