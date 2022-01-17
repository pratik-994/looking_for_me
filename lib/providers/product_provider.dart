// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:looking_for_me/modal/modal.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productPrice: element.get("phoneNo"),
      productName: element.get("name"),
      productImage: element.get("picture"),
      id: element.get("id"),
      productUnit: element.get("job"),
      location: element.get("location"),
    );

    search.add(productModel);
  }

  ////////////////////////today product//////////////////
  // ignore: non_constant_identifier_names
  List<ProductModel> TodayProductList = [];

  fatchTodayProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("workerDetails").get();
    value.docs.forEach(
      (element) {
        productModels(element);

        newList.add(productModel);
      },
    );
    TodayProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getTodayproductDataList {
    return TodayProductList;
  }

/////////////////////////////Drink product//////////////////////////
  // List<ProductModel> drinkProductList = [];

  // fatchdrinkProductData() async {
  //   List<ProductModel> newList = [];
  //   QuerySnapshot value =
  //       await FirebaseFirestore.instance.collection("drinkProduct").get();
  //   value.docs.forEach(
  //     (element) {
  //       productModels(element);

  //       newList.add(productModel);
  //     },
  //   );
  //   drinkProductList = newList;
  //   notifyListeners();
  // }

  // List<ProductModel> get getdrinkproductDataList {
  //   return drinkProductList;
  // }

////////////////////////////////Famous product//////////////////////
  // List<ProductModel> famousProductList = [];

  // fatchfamousProductData() async {
  //   List<ProductModel> newList = [];
  //   QuerySnapshot value =
  //       await FirebaseFirestore.instance.collection("famousProduct").get();
  //   value.docs.forEach(
  //     (element) {
  //       productModels(element);

  //       newList.add(productModel);
  //     },
  //   );
  //   famousProductList = newList;
  //   notifyListeners();
  // }

  // List<ProductModel> get getfamousproductDataList {
  //   return famousProductList;
  // }

  //////////////////search return////////////////////////

  List<ProductModel> get getAllProductSearch {
    return search;
  }
}
