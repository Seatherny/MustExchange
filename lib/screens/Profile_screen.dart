import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mustexchange/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:mustexchange/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:mustexchange/controllers/nav_controller.dart';
import 'package:mustexchange/controllers/home_controller.dart';
import 'package:mustexchange/controllers/my_products_controller.dart';
import 'package:flutter_map/src/layer/marker_layer.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  openAddressDialog(context,UserModel user){
    return Get.defaultDialog(
        title: "My Address",
        titlePadding: EdgeInsets.only(top: 10,bottom: 10),
        titleStyle: myStyle(18, Colors.black, FontWeight.w700),
        middleTextStyle: myStyle(18, Colors.white, FontWeight.w700),
        content: Column(
          children: [
            Text("${user.street}, ${user.city}",style: myStyle(16, Colors.black, FontWeight.w600),
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 13,),
            Container(
              width: MediaQuery.of(context).size.width/1.5,
              height: 300,
              child: FlutterMap(
                      options: MapOptions(
                          center: LatLng(user.lat!,user.lon!)),
                      children: [
                        TileLayer(
                          urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: "com.example.mustexchange",
                        ),
                        // MarkerLayer(
                        //   markers: [
                        //     Marker(
                        //       child: Column(),
                        //       point: LatLng(user.lat!,user.lon!),
                        //       builder: (context) => const Icon(Icons.pin_drop,
                        //             color: Colors.red, size: 45),
                        //       )
                        //   ],
                        // ),
                      ],
                    ),
            ),
            SizedBox(height: 8,),
            InkWell(

              onTap: (){
                Get.find<ProfileController>().updatelocation();
                Get.back();
                Get.snackbar("Sucess", "Location updated successfully");
              },
              child: Container(
              decoration: BoxDecoration(
                color:Colors.indigoAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:Center(
                  child:Text("Change current address",style: myStyle(14, Colors.white, FontWeight.w600),),
                ),
              ),
            ),
            ),
          ],
        ),
        );
  }

      openeditdialog(context){
        return showDialog(
            context: context,
            builder: (context){
              return Dialog(
                child: Container(
                  height: 240,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.emailAddress,
                          style: myStyle(16, Colors.black, FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: myStyle(20, Colors.black, FontWeight.bold),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.number,
                          style: myStyle(16, Colors.black, FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Phone",
                            labelStyle: myStyle(20, Colors.black, FontWeight.bold),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          //update in fire base
                          Database()
                              .edituser(namecontroller.text, phonecontroller.text);
                          //update in ui
                          Get.find<ProfileController>().user.update((user) {
                            user!.username=namecontroller.text;
                            user.phone=phonecontroller.text;
                          });
                          namecontroller.clear();
                          phonecontroller.clear();
                          Get.back();
                          },
                        child:Container(
                          width: MediaQuery.of(context).size.width /2,
                          height: 50,
                          color: Colors.indigoAccent,
                          child: Center(
                              child:Text(
                                "Update",
                                style: myStyle(20, Colors.white,
                                    FontWeight.w700),),
                            ),
                          ),
                        ),
                    ],
              ),
                ),
              );
            }
        );
      }

  uploadnewimage(context)async {
    //pick image from gallery
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    var imagepath = File(image!.path);
    Get.defaultDialog(
    title: "Uploading...",
    content: Text(
    "Uploading your image",
    style: myStyle(20, Colors.black, FontWeight.w700),
    ),
    );

    UploadTask uploadTask = profilefolder
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(imagepath);
    TaskSnapshot snapshot = await uploadTask.whenComplete((){});
    String downloadurl = await snapshot.ref.getDownloadURL();
    usercollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'profilepic':downloadurl
    });
    Get.find<ProfileController>().user.update((user) {
    user!.profilepic=downloadurl;
    });
    Get.back();
  }


  @override
  Widget build(BuildContext context) {
    ProfileController controller= Get.put(ProfileController());
    return RefreshIndicator(
        onRefresh: ()=> controller.getUserData(),
        child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.indigoAccent,
                title: Text("Your account",style: myStyle(20, Colors.white, FontWeight.w700),),
              ),
              body: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Obx(
                          ()=> controller.gotData.value ? Column(
                          children: [
                            Padding(
                               padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                               child: Row(
                                  children: [
                                    InkWell(
                                       onTap: ()=> uploadnewimage(context),
                                       child: Container(
                                         width: 130,
                                         height: 130,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           image: DecorationImage(
                                               image: NetworkImage(controller.user.value.profilepic!),
                                               fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.user.value.username!,style: myStyle(25, Colors.black, FontWeight.w500),),
                                        const SizedBox(height: 2,),
                                        Text("Member since ${controller.user.value.createdAt!.toDate().year}",style: myStyle(13, Colors.grey, FontWeight.w500),),
                                        const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(Icons.phone,color: Colors.grey,size: 14,),
                                              const SizedBox(width: 5,),
                                              Text(controller.user.value.phone!,style: myStyle(14, Colors.grey, FontWeight.w500),),
                                            ],
                                          ),
                                        const SizedBox(height: 15,),
                                        InkWell(
                                            onTap: ()=>openeditdialog(context),
                                            child:Container(
                                            decoration: BoxDecoration(
                                              color:Colors.indigoAccent,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:Center(
                                              child:Text("Edit Account",style: myStyle(14, Colors.white, FontWeight.w600),),
                                            ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ),
                            SizedBox(height: 23,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(controller.userProducts.value.toString(),style: myStyle(18, Colors.black, FontWeight.w600),),
                                    Text("For sale",style: myStyle(18, Colors.grey, FontWeight.w500),),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Text(controller.userSoldProducts.value.toString(),style: myStyle(18, Colors.black, FontWeight.w600),),
                                    Text("Sold",style: myStyle(18, Colors.grey, FontWeight.w500),),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Text("20",style: myStyle(18, Colors.black, FontWeight.w600),),
                                    Text("Contacted",style: myStyle(18, Colors.grey, FontWeight.w500),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),
                            Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: ()=> openAddressDialog(context,controller.user.value),
                                      child:Row(
                                        children: [
                                          Icon(Icons.location_on_rounded,color: Colors.black),
                                          SizedBox(width: 5,),
                                          Text("My Address",style: myStyle(15, Colors.black, FontWeight.w600),),
                                            ],
                                          ),
                                    ),

                                    InkWell(
                                      onTap: (){
                                        Get.delete<NavController>();
                                        Get.delete<HomeController>();
                                        Get.delete<ProfileController>();
                                        Get.delete<MyProductsController>();
                                       // Get.delete<ChatController>();

                                        FirebaseAuth.instance.signOut();
                                      },
                                      child:Row(
                                      children: [
                                        Icon(EvaIcons.settings,color: Colors.black),
                                        SizedBox(width: 5,),
                                        Text("Settings",style: myStyle(15, Colors.black, FontWeight.w600),),
                                      ],
                                    ),
                                    ),

                                  ],
                                ),
                    ),
                          ],
                        )
                              : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
    ),

    );
  }
}
