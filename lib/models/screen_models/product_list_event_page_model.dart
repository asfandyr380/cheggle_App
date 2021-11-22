import 'package:listar_flutter/models/model.dart';

class ProductListEventPageModel {
  final List<ProductEventModel> list;

  ProductListEventPageModel(
    this.list,
  );

  factory ProductListEventPageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductEventModel.fromJson(item);
    }).toList();

    return ProductListEventPageModel(list);
  }
}
