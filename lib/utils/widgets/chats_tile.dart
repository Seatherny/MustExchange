import 'package:flutter/material.dart';
import 'package:mustexchange/screens/chats/view_chats_screen.dart';
import 'package:mustexchange/utils/models/contact_model.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as Tago;

class ChatTile extends StatelessWidget {
  final UserModel userModel;
  final String lastMessage;
  final DateTime timesent;
  ChatTile(this.userModel, this.lastMessage, this.timesent);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: -2, vertical: -1),
          leading: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(userModel.profilepic!),
          ),
          title: Row(
            children: [
              Text(
                userModel.username!,
                style: myStyle(15, Colors.grey, FontWeight.w600),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                Tago.format(timesent),
                style: myStyle(15, Colors.grey, FontWeight.w600),
              ),
            ],
          ),
          subtitle: Text(
            lastMessage,
            style: myStyle(15, Colors.black, FontWeight.w500),
          ),
        ),
        Divider(
          height: 3,
          color: Colors.grey[400],
        )
      ],
    );
  }
}
