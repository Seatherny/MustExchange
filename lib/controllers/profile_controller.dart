import 'package:mustexchange/utils/models/user_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/services/database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mustexchange/utils/variables.dart';


class ProfileController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  RxInt userProducts = 0.obs;
  RxInt userSoldProducts = 0.obs;
  RxInt userContacted = 0.obs;
  RxBool gotData = false.obs;

  Database database = Database();
  String currentuseruid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData()async {
    //user info
    user.value= await database.getUser(currentuseruid);

    //user stats
    userProducts.value= await database.getUserProducts(currentuseruid,false).then((value)=> value.docs.length);

    userSoldProducts.value= await database.getUserProducts(currentuseruid,true).then((value)=> value.docs.length);

    //update state
    gotData.value= true;

  }
  updatelocation()async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permission are permanently denied, we cannot request permissions");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemark[0];
    usercollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'lat':position.latitude,
      'lon': position.longitude,
      'city':place.locality,
      'country':place.country,
      'street':placemark[1].street.toString()
    });
    user.update((UserModel? user) {
      user!.lat=position.latitude;
      user.lon=position.longitude;
      user.city=place.locality;
      user.country=place.country;
      user.street=placemark[1].street.toString();
    });
  }
}