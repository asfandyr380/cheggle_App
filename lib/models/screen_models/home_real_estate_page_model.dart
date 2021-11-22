import 'package:listar_flutter/models/model.dart';

class HomeRealEstatePageModel {
  final List<CountryModel> country;
  final List<CategoryModel> location;
  final List<ProductRealEstateModel> popular;
  final List<ProductRealEstateModel> recommend;

  HomeRealEstatePageModel({
    this.country,
    this.location,
    this.popular,
    this.recommend,
  });

  factory HomeRealEstatePageModel.fromJson(Map<String, dynamic> json) {
    return HomeRealEstatePageModel(
      country: (json['country'] as List ?? []).map((e) {
        return CountryModel.fromJson(e);
      }).toList(),
      location: (json['location'] as List ?? []).map((e) {
        return CategoryModel.fromJson(e);
      }).toList(),
      popular: (json['popular'] as List ?? []).map((e) {
        return ProductRealEstateModel.fromJson(e);
      }).toList(),
      recommend: (json['recommend'] as List ?? []).map((e) {
        return ProductRealEstateModel.fromJson(e);
      }).toList(),
    );
  }
}
