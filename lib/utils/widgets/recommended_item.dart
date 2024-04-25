import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/utils/models/product_model.dart';

class RecommendedItem extends StatelessWidget {
  final ProductModel product;
  RecommendedItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      Expanded(
                          child: Text(
                            "15s1",
                            style: myStyle(14, Colors.grey, FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          ),
                      )
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
        );
  }
}
