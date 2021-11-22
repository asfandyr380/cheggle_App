import 'package:listar_flutter/models/model.dart';

class SearchHistoryRealEstatePageModel {
  final List<CategoryModel> discover;
  final List<ProductRealEstateModel> recently;
  final List<ProductRealEstateModel> history;

  SearchHistoryRealEstatePageModel({
    this.discover,
    this.recently,
    this.history,
  });

  factory SearchHistoryRealEstatePageModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorDiscover = json['discover'] ?? [];
    final Iterable refactorRecently = json['recently'] ?? [];
    final Iterable refactorHistory = json['history'] ?? [];

    final listDiscover = refactorDiscover.map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    final listRecently = refactorRecently.map((item) {
      return ProductRealEstateModel.fromJson(item);
    }).toList();

    final listHistory = refactorHistory.map((item) {
      return ProductRealEstateModel.fromJson(item);
    }).toList();

    return SearchHistoryRealEstatePageModel(
      discover: listDiscover,
      recently: listRecently,
      history: listHistory,
    );
  }
}
