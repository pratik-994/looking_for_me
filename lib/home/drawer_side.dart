// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:looking_for_me/Widget/colors.dart';
import 'package:looking_for_me/home/home_screen.dart';

class DrawerSide extends StatefulWidget {
  // UserProvider userProvider;
  // DrawerSide({required this.userProvider});
  //const ({ Key? key }) : super(key: key);
  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        width: 100,
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      radius: 43,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.yellow,
                        // backgroundImage: NetworkImage(userData.userImage),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Text(userData.userName),
                        // Text(
                        //   userData.email,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            listTile(
                iconData: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }),
            // listTile(
            //     iconData: Icons.shop_outlined,
            //     title: "Review order",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ReviewCart(),
            //         ),
            //       );
            //     }),
            // listTile(
            //     iconData: Icons.person_outline,
            //     title: "My Profile",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) =>
            //               MyProfile(userProvider: widget.userProvider),
            //         ),
            //       );
            //     }),
            // listTile(
            //     iconData: Icons.notifications_outlined,
            //     title: "Notification",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ReviewCart(),
            //         ),
            //       );
            //     }),
            // listTile(
            //     iconData: Icons.star_outline,
            //     title: "Rating and Review",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ReviewCart(),
            //         ),
            //       );
            //     }),
            // listTile(
            //     iconData: Icons.favorite_outline,
            //     title: "Wishlist",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => WishList(),
            //         ),
            //       );
            //     }),
            // listTile(
            //     iconData: Icons.copy_outlined,
            //     title: "Raise a Complant",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ReviewCart(),
            //         ),
            //       );
            //     }),
            // listTile(
            //     iconData: Icons.format_quote_outlined,
            //     title: "FAQS",
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ReviewCart(),
            //         ),
            //       );
            //     }),
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('COntact Support '),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Call us: "),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Will be updates soon"),
                    ],
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text("Mail us: "),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Will be updates soon"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
