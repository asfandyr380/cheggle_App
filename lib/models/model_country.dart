import 'package:listar_flutter/configs/config.dart';

class CountryModel {
  final String code;
  final String name;
  final String image;

  CountryModel(
    this.code,
    this.name,
    this.image,
  );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return CountryModel(
      json['code'] ?? "Unknown",
      json['name'] ?? "Unknown",
      json['image'] ?? Images.Logo,
    );
  }
}
