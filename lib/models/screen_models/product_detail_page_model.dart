import 'package:listar_flutter/models/model.dart';

class ProductDetailPageModel {
  final ProductModel product;
  final List<TabModel> tab;

  ProductDetailPageModel({
    this.product,
    this.tab,
  });

  static List<TabModel> _setTab(tab) {
    if (tab != null) {
      final Iterable refactorTab = tab ?? [];
      return refactorTab.map((item) {
        return TabModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  factory ProductDetailPageModel.fromJson(Map<String, dynamic> json) {
    print(json['auther']);
    return ProductDetailPageModel(
      product: ProductModel.fromJson(json),
      tab: _setTab(json['tab']),
    );
  }
}
