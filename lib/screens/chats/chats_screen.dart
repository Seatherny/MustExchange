import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustexchange/controllers/chats_controller.dart';
import 'package:mustexchange/screens/chats/view_chats_screen.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/utils/widgets/chats_tile.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatsController chatsController = Get.put(ChatsController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Material(
              elevation: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.14,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Messages",
                        style: myStyle(23, Colors.black, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 3),
              itemCount: chatsController.chatslist.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: chatsController.chatslist[index].userModel,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return InkWell(
                      onTap: () => Get.to(() => Viewchat(snapshot.data)),
                      child: ChatTile(
                          snapshot.data,
                          chatsController.chatslist[index].lastmessage,
                          chatsController.chatslist[index].timesent),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
