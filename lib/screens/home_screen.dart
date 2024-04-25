import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mustexchange/utils/widgets/category_item.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:mustexchange/utils/widgets/featured_item.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mustexchange/controllers/home_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:mustexchange/utils/widgets/recommended_item.dart';
import 'package:flutter_staggered_grid_view/src/widgets/staggered_grid.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 40,
              margin: EdgeInsets.only(left: 12, right: 12, top: 80),
              decoration: BoxDecoration(color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16)),
              child: TextField(
                style: myStyle(14, Colors.black, FontWeight.w500),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                        Icons.search, size: 18, color: Colors.black),
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: myStyle(14, Colors.black, FontWeight.w500)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 12, bottom: 3),
              child: Text(
                "Browse Categories",
                style: myStyle(17, Colors.black, FontWeight.w600),
              ),
            ),
            Container(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  CategoryItem(const Color(0xffB0E0E6), EvaIcons.clipboard,
                      "Stationary"),
                  CategoryItem(
                      const Color(0xffffc0cb), EvaIcons.eye, "Cosmetics"),
                  CategoryItem(Colors.amber, EvaIcons.gift, "Jewellery"),
                  CategoryItem(
                      const Color(0xffE2A76F), EvaIcons.cube, "Footwear"),
                  CategoryItem(
                      const Color(0xffB0E0E6), EvaIcons.checkmarkSquare2Outline,
                      "Grocery"),
                  CategoryItem(const Color(0xff82CAFF), EvaIcons.shoppingBag,
                      "Clothing"),
                  CategoryItem(
                      const Color(0xffFFCBA4), EvaIcons.home, "Furniture"),
                  CategoryItem(
                      const Color(0xff9E7BFF), EvaIcons.bookOpen, "Books"),
                  CategoryItem(Colors.brown!, EvaIcons.plus, "Others"),
                ],
              ),
            ),
            GetX<HomeController>(
              init: Get.put(HomeController()),
              builder: (controller)=> Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12, bottom: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured",
                            style: myStyle(17, Colors.black, FontWeight.w600),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.black,
                                size: 24,
                              ))
                        ],
                      )
                  ),
                  const SizedBox(height: 5),

                  CarouselSlider.builder(
                    options: CarouselOptions(aspectRatio: 16 / 9, autoPlay: true),
                    itemCount: controller.featuredlist.length,
                    itemBuilder: (context, index, pageview) {
                      return controller.featuredlist.isEmpty ?
                        Padding(
                          padding: const EdgeInsets.all(60),
                          child: Text(
                          "no items yet",
                        style: myStyle(18, Colors.grey, FontWeight.w700),
                        ),
                        )
                      : FeaturedItem(controller.featuredlist[index]);
                    },
                  ),

                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommended",
                            style: myStyle(17, Colors.black, FontWeight.w600),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.black,
                                size: 24,
                              ),)
                        ],
                      )
                  ),

                  StaggeredGrid.count(
                    crossAxisCount: 2,
                    children : controller.recommendedlist.map((product)=>RecommendedItem(product)).toList(),
                  ),
                ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}
