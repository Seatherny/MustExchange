import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:get/get.dart';
import 'package:mustexchange/screens/search_screen.dart';

class CategoryItem extends StatelessWidget {
  final Color bgcolor;
  final IconData icon;
  final String title;

  CategoryItem(this.bgcolor,this.icon,this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ()=> Get.to(SearchScreen('', title)),
        child:Padding(
        padding: const EdgeInsets.only(left:13),
          child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: bgcolor,borderRadius: BorderRadius.circular(70),
          ),
          child: Icon(icon),
        ),
        SizedBox(height:8),
        Text(title,style: myStyle(13, Colors.black, FontWeight.w500),),
      ],
    ),
    ),
    );
  }
}
