import 'package:listar_flutter/models/model.dart';

class ProductListFoodPageModel {
  final List<ProductFoodModel> list;

  ProductListFoodPageModel(
    this.list,
  );

  factory ProductListFoodPageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductFoodModel.fromJson(item);
    }).toList();

    return ProductListFoodPageModel(list);
  }
}
