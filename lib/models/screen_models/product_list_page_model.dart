import 'package:listar_flutter/models/model.dart';

class ProductListPageModel {
  final List<ProductModel> list;

  ProductListPageModel(
    this.list,
  );

  factory ProductListPageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    return ProductListPageModel(list);
  }
}
