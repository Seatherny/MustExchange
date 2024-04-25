import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/utils/models/product_model.dart';


class FeaturedItem extends StatelessWidget {
  final ProductModel product;
  FeaturedItem(this.product);
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
             Container(
                height: 290,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                          elevation: 5,
                          child: Image(
                              fit:BoxFit.fill,
                              alignment: Alignment.topCenter,
                              image: NetworkImage(
                                product.images![0]
                              ),
                          ),
                  ),
                ),
             ),
          Align(
            alignment: Alignment.bottomRight,
                child:Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child:Text(
                      "${product.price} \$",
                      style:myStyle(16, Colors.grey, FontWeight.w700),
                  ),
          ),
          ),
          ),
    ],
    );
  }
}
