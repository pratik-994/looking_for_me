// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:looking_for_me/Widget/single_worker.dart';
import 'package:looking_for_me/color/app_color.dart';
import 'package:looking_for_me/route_page/routing_page.dart';

import 'package:looking_for_me/screens/details_page.dart/details_screen.dart';
import 'package:looking_for_me/user_model/user_model.dart';

late UserModel userModel;

Size? size;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userModel = UserModel.fromDocument(documentSnapshot);
        } else {
          print("Document does not exist the database");
        }
      },
    );
  }

  // Widget buildCategory() {
  //   return Column(
  //     children: [
  //       ListTile(
  //         leading: Text(
  //           "Categories",
  //           style: TextStyle(
  //             fontSize: 20,
  //             color: Colors.grey[600],
  //             fontWeight: FontWeight.normal,
  //           ),
  //         ),
  //       ),
  //     Container(
  //       height: size!.height * 0.1 + 20,
  //       child: StreamBuilder(
  //         stream:
  //             FirebaseFirestore.instance.collection("categories").snapshots(),
  //         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
  //           if (!streamSnapshort.hasData) {
  //             return Center(child: const CircularProgressIndicator());
  //           }
  //           return ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             physics: BouncingScrollPhysics(),
  //             itemCount: streamSnapshort.data!.docs.length,
  //             itemBuilder: (ctx, index) {
  //               return Categories(
  //                 onTap: () {
  //                   Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                       builder: (context) => GridViewWidget(
  //                         subCollection: streamSnapshort.data!.docs[index]
  //                             ["categoryName"],
  //                         collection: "categories",
  //                         id: streamSnapshort.data!.docs[index].id,
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 categoryName: streamSnapshort.data!.docs[index]
  //                     ["categoryName"],
  //                 image: streamSnapshort.data!.docs[index]["categoryImage"],
  //               );
  //             },
  //           );
  //         },
  //       ),
  //     ),
  //   ],
  // );
  //}

  Widget buildProduct(
      {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
    return SizedBox(
      height: size!.height / 3 + 40,
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
          if (!streamSnapshort.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshort.data!.docs.length,
            itemBuilder: (ctx, index) {
              var varData = searchFunction(query, streamSnapshort.data!.docs);
              var data = varData[index];
              // var data = streamSnapshort.data!.docs[index];
              return SingleProduct(
                onTap: () {
                  RoutingPage.goTonext(
                    context: context,
                    navigateTo: DetailsPage(
                      // productCategory: data["productCategory"],
                      // productId: data["productId"],
                      // productImage: data["productImage"],
                      // productName: data["productName"],
                      // productOldPrice: data["productOldPrice"],
                      // productPrice: data["productPrice"],
                      // productRate: data["productRate"],
                      // productDescription: data["productDescription"],
                      id: data["id"],
                      job: data["job"],
                      location: data["location"],
                      name: data["name"],
                      phoneNo: data["phoneNo"],
                      picture: data["picture"],
                    ),
                  );
                },
                id: data["id"],
                job: data["job"],
                location: data["location"],
                name: data["name"],
                phoneNo: data["phoneNo"],
                picture: data["picture"],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    getCurrentUserDataFunction();
    return Scaffold(
      // drawer: BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
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
                  hintText: "Search Your Worker",
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          query == ""
              ? Column(
                  children: [
                    // buildCategory(),
                    // // ignore: prefer_const_constructors
                    // ListTile(
                    //   leading: Text(
                    //     "Products",
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.normal,
                    //     ),
                    //   ),
                    // ),
                    buildProduct(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                    ),
                    ListTile(
                      leading: Text(
                        "Available People worker",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    buildProduct(
                      stream: FirebaseFirestore.instance
                          .collection("workerDetails")
                          .where("productRate", isGreaterThan: 4)
                          .orderBy(
                            "productRate",
                            descending: true,
                          )
                          .snapshots(),
                    ),
                  ],
                )
              : Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("workerDetails")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                      if (!streamSnapshort.hasData) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      var varData =
                          searchFunction(query, streamSnapshort.data!.docs);
                      return result.isEmpty
                          ? Center(child: Text("Not Found"))
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: result.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                        // productCategory:
                                        //     data["productCategory"],
                                        // productId: data["productId"],
                                        // productImage: data["productImage"],
                                        // productName: data["productName"],
                                        // productOldPrice:
                                        //     data["productOldPrice"],
                                        // productPrice: data["productPrice"],
                                        // productRate: data["productRate"],
                                        // productDescription:
                                        //     data["productDescription"],
                                        id: data["id"],
                                        job: data["job"],
                                        location: data["us"],
                                        name: data["name"],
                                        phoneNo: data["phoneNo"],
                                        picture: data["picture"],
                                      ),
                                    );
                                  },
                                  id: data["id"],
                                  job: data["job"],
                                  location: data["us"],
                                  name: data["name"],
                                  phoneNo: data["phoneNo"],
                                  picture: data["picture"],
                                );
                              },
                            );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories({
    Key? key,
    required this.onTap,
    required this.categoryName,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        width: size!.width / 2 - 20,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.7),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
