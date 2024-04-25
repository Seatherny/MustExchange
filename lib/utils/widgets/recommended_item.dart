import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:mustexchange/services/database.dart';
import 'package:mustexchange/utils/models/user_model.dart';
import 'package:mustexchange/screens/view_products_screen.dart';
import 'package:get/get.dart';


class RecommendedItem extends StatelessWidget {
  final ProductModel product;
  RecommendedItem(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.to(() => ViewProductsScreen(product)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          child: Card(
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width/2,
                  height: 130,
                  image: NetworkImage(product.images![0]),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 2, top:8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on, size: 14,color: Colors.grey,
                      ),
                      const SizedBox(width: 3,),
                      FutureBuilder<UserModel>(
                        future: Database().getUser(product.useruid!),
                        builder: (context,AsyncSnapshot<UserModel> snapshot) {
                         if(!snapshot.hasData){
                           return Container();
                         }

                          return Expanded(
                            child: Text(
                              snapshot.data!.city!,
                              style: myStyle(14, Colors.grey, FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          );
                        }
        ),
                  ],
                ),
                ),
                Padding(padding: const EdgeInsets.only(right: 8,left: 8,top: 4),
                  child: Text(
                    product.title!,
                    style: myStyle(16, Colors.black, FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(right: 2,left: 8,top: 5,bottom: 4),
                  child: Text(
                    "${product.price} \$",
                    style: myStyle(15, Colors.grey, FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}
