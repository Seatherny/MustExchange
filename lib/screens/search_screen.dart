import 'package:flutter/material.dart';
import 'package:mustexchange/utils/variables.dart';
import 'package:mustexchange/utils/widgets/myadd_item.dart';
import 'package:mustexchange/utils/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  final String type;

  SearchScreen(this.query, this.type);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

  class _SearchScreenState extends State<SearchScreen> {
  late Future queryfuture;

  @override
  void initState(){
    super.initState();
    setState(() {
      queryfuture=widget.type == "Search" ? productcollection
          .where('title',isGreaterThanOrEqualTo: widget.query)
          .where('title',isLessThanOrEqualTo: "${widget.query}~")
          .get() : productcollection.where("category",isEqualTo: widget.type).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.type == "Search"
            ? PreferredSize (
              child:AppBar(

                backgroundColor: Colors.indigoAccent,
                centerTitle: true,
                title: Container(
                  height: 34,
                  child: TextFormField(
                    initialValue: widget.query,
                    textAlign: TextAlign.left,
                    style: myStyle (15,Colors.black, FontWeight.w500),
                    onFieldSubmitted: (value){
                      setState(() {
                        queryfuture=productcollection
                            .where('title',isGreaterThanOrEqualTo: value)
                            .where('title',isLessThanOrEqualTo: "${value}~")
                            .get();
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left:10,bottom:10),
                        fillColor: Colors.white,
                        filled: true
                    ),
                ),
              ),
              ),
              preferredSize: Size.fromHeight(58))
      : PreferredSize(
          child: AppBar(
            backgroundColor: Colors.indigoAccent,
            centerTitle: true,
            title: Text(widget.type,style: myStyle(20, Colors.white, FontWeight.w700),),

          ),
          preferredSize: Size.fromHeight(50),
        ),

        body: FutureBuilder(
          future: queryfuture,
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  QueryDocumentSnapshot<Object?> doc= snapshot.data.docs[index];
                  return MyAdItem(ProductModel.fromDocumentSnapshot(doc));
                },
            );
          },
        )
    );


  }
  }