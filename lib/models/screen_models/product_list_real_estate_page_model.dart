import 'package:listar_flutter/models/model.dart';

class ProductListRealEstatePageModel {
  final List<ProductRealEstateModel> list;

  ProductListRealEstatePageModel(
    this.list,
  );

  factory ProductListRealEstatePageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductRealEstateModel.fromJson(item);
    }).toList();

    return ProductListRealEstatePageModel(list);
  }
}
