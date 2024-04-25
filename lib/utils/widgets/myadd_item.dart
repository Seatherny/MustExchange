import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:mustexchange/services/database.dart';
import 'package:get/get.dart';
import 'package:mustexchange/screens/view_products_screen.dart';


class MyAdItem extends StatelessWidget {
  final ProductModel product;
  MyAdItem(this.product);

  Database database =Database();

@override
Widget build(BuildContext context) {

  return InkWell(
    onTap: ()=> Get.defaultDialog(
      title: "Choose:",
      titleStyle: myStyle(22, Colors.indigoAccent, FontWeight.w600),
      content: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
                child: InkWell(
                onTap: () {
                  database.deleteproduct(product.id!);
                  Get.back();
                },
                child: Text(
                  "Delete",
                  style: myStyle(20, Colors.black, FontWeight.w600),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                database.changeStatus(product.sold!, product.id!);
                Get.back();
              },
              child: Text(
                  product.sold! ? "For sale" : "Mark sold ",
                  style: myStyle(22, Colors.black, FontWeight.w600),
                ),
            ),
            ],
        ),
      )),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child:Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(image:
                    NetworkImage( product.images![0]),
                        fit: BoxFit.cover)),
                  ),
              Container(
                width:MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  children: [
                    const SizedBox(
                        width:15
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height:10,
                        ),
                        Text(product.title! ,style: myStyle(18, Colors.black, FontWeight.w600),),
                        const SizedBox(
                          height:2,
                        ),
                        Text(product.category!,style: myStyle(18, Colors.grey, FontWeight.w600),),
                        const SizedBox(
                          height:10,
                        ),
                          Text("${product.price!} \$",style: myStyle(18, Colors.black, FontWeight.w600),),
                        ],
                      ),
                      Spacer(),

                      IconButton(
                        onPressed: ()=> Get.to(ViewProductsScreen(product)),
                        icon: const Icon(Icons.arrow_forward_ios_sharp),
                      color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      )
  );
}
}
