import 'package:flutter/material.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mustexchange/screens/addproduct/title_screen.dart';
import 'package:timeago/timeago.dart'as tago;
import 'package:mustexchange/utils/variables.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/src/layer/marker_layer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:mustexchange/controllers/view_product_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mustexchange/services/database.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustexchange/screens/chats/view_chats_screen.dart';


class ViewProductsScreen extends StatelessWidget {
  final ProductModel product;

  ViewProductsScreen(this.product);
  TextEditingController reportcontroller = TextEditingController();

  openAddressDialog(street, city, country) {
    return Get.defaultDialog(
        title: "Product Address",
        titlePadding: EdgeInsets.all(15),
        middleText: "$street, $city $country",
        backgroundColor: Colors.indigoAccent,
        titleStyle: myStyle(20, Colors.white, FontWeight.w700),
        middleTextStyle: myStyle(18, Colors.white, FontWeight.w700),
        radius: 30);
  }

  openReportDialog(UserModel user, context) {
    return Get.defaultDialog(
        title: "Report ${user.username}",
        titleStyle: myStyle(19, Colors.black, FontWeight.w700),
        content: Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              controller: reportcontroller,
              maxLines: null,
              decoration: InputDecoration(
                  labelText: 'Tell us why ?',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1))),
            ),
            SizedBox(
              height: 17,
            ),
            InkWell(
              onTap: () {
                Database().reportuser(user.uid, reportcontroller.text);
                reportcontroller.clear();
                Get.back();
                Get.snackbar("Success", "User reported successfully",
                    backgroundColor: Colors.greenAccent);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.7,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigoAccent),
                child: Center(
                  child: Text(
                    "Report",
                    style: myStyle(18, Colors.white, FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
        titlePadding: EdgeInsets.only(top: 12, bottom: 12));
  }

  @override
  Widget build(BuildContext context) {
    print(product.useruid);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: product.images!.length,
              itemBuilder: (context, index, pageview) {
                return ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Image(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2.2,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        product.images![index],
                      )
                  ),
                );
              },
              options: CarouselOptions(viewportFraction: 1),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.category!,
                        style: myStyle(16, Colors.grey[500]!, FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        tago.format(product.date!.toDate()),
                        style: myStyle(16, Colors.grey[500]!, FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title!,
                        style: myStyle(22, Colors.black, FontWeight.w600),
                      ),
                      Text(
                        "\₹ ${product.price} ",
                        style: myStyle(22, Colors.black, FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    product.description!,
                    style: myStyle(16, Colors.grey[500]!, FontWeight.w600),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Location of the item",
                    style: myStyle(18, Colors.black, FontWeight.w600),
                  ),
                ],
              ),
            ),
            GetX(
              init: ViewProductController(product.useruid!),
              builder: (ViewProductController controller) => controller
                  .user.value.uid ==
                  null
                  ? Container()
                  : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 200,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(controller.user.value.lat!,
                            controller.user.value.lon!),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.mustexchange',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(controller.user.value.lat!,
                                  controller.user.value.lon!),
                              // This is a change introduced in flutter_map in
                              // version 6.0.0 as you can see here
                              // https://pub.dev/packages/flutter_map/changelog.
                              // If you use older versions you could use the
                              // builder that you now have in your code
                              child: IconButton(
                                onPressed: () => openAddressDialog(
                                    controller.user.value.street,
                                    controller.user.value.city,
                                    controller.user.value.country),
                                icon: const Icon(
                                  Icons.pin_drop,
                                  color: Colors.red,
                                  size: 45,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  controller.user.value.profilepic!))),
                    ),
                    title: Text(
                      controller.user.value.username!,
                      style: myStyle(16, Colors.black, FontWeight.w600),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                          controller.user.value.createdAt!.toDate()),
                      style:
                      myStyle(14, Colors.grey[500]!, FontWeight.w600),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => openReportDialog(
                              controller.user.value, context),
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]),
                            child: Center(
                              child: Text(
                                "Report",
                                style: myStyle(16, Colors.indigoAccent,
                                    FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => Get.to(
                                  () => Viewchat(controller.user.value)),
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.indigoAccent),
                            child: Center(
                              child: Text(
                                "Message",
                                style: myStyle(
                                    16, Colors.white, FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
