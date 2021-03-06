// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:looking_for_me/Widget/colors.dart';
import 'package:looking_for_me/home/singal_product.dart';
import 'package:looking_for_me/providers/product_provider.dart';
import 'package:looking_for_me/screens/worker_overview.dart';
import 'package:looking_for_me/search/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  Widget _buildTodayProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Workers available'),
              // Text(
              //   'view all',
              //   style: TextStyle(color: Colors.grey),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Search(
                      search: productProvider.getTodayproductDataList,
                    ),
                  ));
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getTodayproductDataList.map(
              (todayproductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          // productQuantity: todayproductData.prof,
                          productId: todayproductData.id,
                          location: todayproductData.location,
                          productPrice: todayproductData.productPrice,
                          productName: todayproductData.productName,
                          productImage: todayproductData.productImage,
                          productQuantity: "",
                        ),
                      ),
                    );
                  },
                  productId: todayproductData.id,
                  // productprice: todayproductData.productPrice,
                  productImage: todayproductData.productImage,
                  productName: todayproductData.productName,
                  productUnit: todayproductData, productprice: 1,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchTodayProductData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    //  UserProvider userProvider = Provider.of(context);
    //  userProvider.getUserData();
    return Scaffold(
      // backgroundColor: Color(0xff0c0f14),
      backgroundColor: Colors.white,
      //  drawer: DrawerSide(userProvider: userProvider),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xffd6d382),
            child: IconButton(
              // onPressed: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => Search(),
              //   ));
              // },
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Search(
                    search: productProvider.getAllProductSearch,
                  ),
                ));
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => ReviewCart(),
                //   ),
                // );
              },
              child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 12,
                child: Icon(
                  Icons.shop,
                  size: 17,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://d2zqka2on07yqq.cloudfront.net/wp-content/uploads/2020/06/Law-Risk-Management-_-Cover-1-1536x751-1.png'),
                  ),
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      //color: Colors.red,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 150, bottom: 10),
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                // color: Color(0xffd1ad17),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50)),
                              ),
                            ),
                          ),
                          Text(
                            'easily hire',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Workers in your nearby area',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
            _buildTodayProduct(context),
          ],
        ),
      ),
    );
  }
}
