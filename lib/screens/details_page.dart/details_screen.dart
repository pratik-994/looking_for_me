// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:looking_for_me/components/secondpart.dart';
import 'package:looking_for_me/components/top_part2.dart';

class DetailsPage extends StatelessWidget {
  // final String productImage;
  // final String productName;
  // final String productCategory;
  // final double productPrice;
  // final String productId;
  // final double productOldPrice;
  // final int productRate;
  // final String productDescription;

  final String id;
  List<dynamic> job;
  final String location;
  final String name;
  final String phoneNo;
  final String picture;

  DetailsPage({
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPart(
              picture: picture,
            ),
            SecondPart(
                id: id,
                job: job,
                location: location,
                name: name,
                phoneNo: phoneNo,
                picture: picture)
          ],
        ),
      ),
    );
  }
}
