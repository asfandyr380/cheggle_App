import 'package:listar_flutter/models/model.dart';

class ProductDetailFoodPageModel {
  final ProductFoodModel product;

  ProductDetailFoodPageModel({
    this.product,
  });

  factory ProductDetailFoodPageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailFoodPageModel(
      product: ProductFoodModel.fromJson(json),
    );
  }
}
