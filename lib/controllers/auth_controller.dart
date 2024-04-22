import 'package:get/get.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mustexchange/Authentication/registerscreen.dart';
import 'package:mustexchange/Authentication/login_screen.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';


class AuthController extends GetxController {
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString city = "".obs;
  RxString country = "".obs;
  RxString streetname = "".obs;

  FirebaseAuth auth= FirebaseAuth.instance;
  Rx<User?> firebaseuser = Rx<User?>(FirebaseAuth.instance.currentUser);

  @override
  void onInit() {
    super.onInit();
    firebaseuser.bindStream(auth.authStateChanges());
  }

  createuser(String email, String password, String name, dynamic phone) async {
    try {
      UserCredential registereduser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      usercollection.doc(registereduser.user!.uid).set({
        'name' : name,
        'email': email,
        'password': password,
        'date': DateTime.now(),
        'phone': phone,
        'city': city.value,
        'country': country.value,
        'lat': double.parse(latitude.value),
        'lon': double.parse(longitude.value),
        'street': streetname.value,
        'profilepic': "/Users/idckgaf/Downloads/boyyyyyy.jpg"
      });
      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }


  login(String email, String password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch (e){
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }

  signout() {}

  getlocation() async {
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
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();

    getAddressFormLatLang(position);
  }


  getAddressFormLatLang(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemark[0];

    if (place.locality != null) {
      city.value = place.locality!;
    }

    if (place.country != null) {
      country.value = place.country!;
    }
    streetname.value = placemark[0].street.toString();
  }
}
