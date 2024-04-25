import 'package:get/get.dart';
import 'package:mustexchange/services/database.dart';
import 'package:mustexchange/utils/models/user_model.dart';

class ViewProductController extends GetxController{
  final String useruid;
  ViewProductController(this.useruid);

  Database database = Database();
  Rx<UserModel> user = UserModel().obs;

  @override
  void onInit(){
    getUserData(useruid);
    super.onInit();
  }

  Future<void> getUserData(String useruid) async{
    user.value= await database.getUser(useruid);
  }
}