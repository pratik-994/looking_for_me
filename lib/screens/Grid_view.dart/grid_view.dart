// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:looking_for_me/Widget/single_worker.dart';
import 'package:looking_for_me/color/app_color.dart';
import 'package:looking_for_me/route_page/routing_page.dart';
import 'package:looking_for_me/screens/details_page.dart/details_screen.dart';

class GridViewWidget extends StatefulWidget {
  final String id;
  final String collection;
  final String subCollection;

  const GridViewWidget({
    Key? key,
    required this.subCollection,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  String query = "";
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["name"].toUpperCase().contains(query) ||
          element["name"].toLowerCase().contains(query) ||
          element["name"].toUpperCase().contains(query) &&
              element["name"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.collection)
            .doc(widget.id)
            .collection(widget.subCollection)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
          if (!snapshort.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var varData = searchFunction(query, snapshort.data!.docs);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 7,
                  shadowColor: Colors.grey[300],
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      fillColor: AppColors.KwhiteColor,
                      hintText: "Search Your Product",
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              result.isEmpty
                  ? Text("Not Found")
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: result.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (ctx, index) {
                        var data = varData[index];
                        return SingleProduct(
                          onTap: () {
                            RoutingPage.goTonext(
                              context: context,
                              navigateTo: DetailsPage(
                                id: data["id"],
                                job: data["job"],
                                location: data["location"],
                                name: data["name"],
                                phoneNo: data["phoneNO"],
                                picture: data["picture"],
                              ),
                            );
                          },
                          // productId: data["productId"],
                          // productCategory: data["productCategory"],
                          // productRate: data["productRate"],
                          // productOldPrice: data["productOldPrice"],
                          // productPrice: data["productPrice"],
                          // productImage: data["productImage"],
                          // productName: data["productName"],
                          id: data["id"],
                          job: data["job"],
                          location: data["location"],
                          name: data["name"],
                          phoneNo: data["phoneNO"],
                          picture: data["picture"],
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}