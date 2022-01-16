// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:looking_for_me/Widget/my_button.dart';

class SecondPart extends StatelessWidget {
  final String id;
  List<dynamic> job;
  final String location;
  final String name;
  final String phoneNo;
  final String picture;

  SecondPart({
    Key? key,
    required this.id,
    required this.job,
    required this.location,
    required this.name,
    required this.phoneNo,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text("\$$phoneNo"),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 2,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: BoxDecoration(
              //         color: AppColors.Kgradient1,
              //         borderRadius: BorderRadius.circular(6),
              //       ),
              //       child: Center(
              //         child: Text(
              //           productRate.toString(),
              //           style: TextStyle(
              //             color: AppColors.KwhiteColor,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Text(
              //       "50 Reviews",
              //       style: TextStyle(
              //         color: AppColors.Kgradient1,
              //       ),
              //     )
              //   ],
              // ),
              //     Divider(
              //       thickness: 2,
              //     ),
              //   ],
              // ),
              // Text(
              //   "Description",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Text(
              //   productDescription,
              //   style: TextStyle(),
              // ),
              MyButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("cart")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("userCart")
                      .doc(id)
                      .set(
                    {
                      // "productId": productId,
                      // "productImage": productImage,
                      // "productName": productName,
                      // "productPrice": productPrice,
                      // "productOldPrice": productPrice,
                      // "productRate": productRate,
                      // "productDescription": productDescription,
                      // "productQuantity": 1,
                      // "productCategory": productCategory,
                    },
                  );
                  // RoutingPage.goTonext(
                  //   context: context,
                  // //  navigateTo: CartPage(),
                  // );
                },
                text: "Add to Cart",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
