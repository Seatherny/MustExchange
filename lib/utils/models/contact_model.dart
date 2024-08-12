import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/utils/models/user_model.dart';

class ContactModel {
  Future<UserModel> userModel;
  String lastmessage;
  DateTime timesent;

  ContactModel(this.userModel, this.lastmessage, this.timesent);
}
