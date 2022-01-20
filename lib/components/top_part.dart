// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:looking_for_me/color/app_color.dart';


class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              // child: Image.asset(
              //   "images/logo1.png",
              //   scale: 8,
              // ),
            ),
            Text(
              "Looking For Me",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Login",
              style: TextStyle(
                color: AppColors.KblackColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
