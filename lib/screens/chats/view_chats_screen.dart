import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustexchange/services/database.dart';
import 'package:mustexchange/utils/models/message_model.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as tago;

class Viewchat extends StatelessWidget {
  final UserModel user;
  Viewchat(this.user);

  TextEditingController chatcontroller = TextEditingController();
  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(user.username!,
            style: myStyle(20, Colors.white, FontWeight.w700)),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: usercollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('chats')
              .doc(user.uid)
              .collection('messages')
              .orderBy('timesent')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            QuerySnapshot<Object?>? snapshots = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: GroupedListView<Message, DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    elements: snapshots!.docs
                        .map((e) => Message.fromDocumentSnapshot(e))
                        .toList(),
                    groupBy: (message) => DateTime(message.time.year,
                        message.time.month, message.time.day),
                    groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Colors.indigoAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.time),
                              style: myStyle(12, Colors.white, FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, Message message) {
                      return message.sentByMe
                          ? InkWell(
                        onDoubleTap: () => database.deletemessage(
                            message.messageid, message.recieveruid),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 8, top: 4, bottom: 4),
                            child: Card(
                              elevation: 8,
                              color: Colors.indigoAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  message.message,
                                  style: myStyle(
                                      14, Colors.white, FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 50, left: 8, top: 4, bottom: 4),
                          child: Card(
                            elevation: 8,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                message.message,
                                style: myStyle(14, Colors.indigoAccent,
                                    FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: TextField(
                      maxLines: null,
                      style: myStyle(20, Colors.black, FontWeight.w400),
                      controller: chatcontroller,
                      decoration: InputDecoration(
                          hintText: 'Message..',
                          hintStyle: myStyle(15, Colors.grey, FontWeight.w600)),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          database.sendmessage(user.uid, chatcontroller.text);
                          chatcontroller.clear();
                        },
                        icon: const Icon(Icons.send,
                            size: 28, color: Colors.indigoAccent)),
                  ),
                )
              ],
            );
          }),
    );
  }
}