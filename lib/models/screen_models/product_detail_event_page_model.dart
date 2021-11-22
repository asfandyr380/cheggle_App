import 'package:listar_flutter/models/model.dart';

class ProductDetailEventPageModel {
  final ProductEventModel product;

  ProductDetailEventPageModel({
    this.product,
  });

  factory ProductDetailEventPageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailEventPageModel(
      product: ProductEventModel.fromJson(json),
    );
  }
}
