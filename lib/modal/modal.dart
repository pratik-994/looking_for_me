class ProductModel {
  String productName;
  String productImage;
  String productPrice;
  String id;
  String location;
  List<dynamic> productUnit;
  ProductModel(
      {required this.location,
      required this.id,
      required this.productUnit,
      required this.productImage,
      required this.productName,
      required this.productPrice});
}
