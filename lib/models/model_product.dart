import 'package:listar_flutter/models/model.dart';

enum DetailViewStyle { basic, tab }

enum ProductViewType { small, gird, list, block, cardLarge, cardSmall }

class ProductModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String createDate;
  final num rate;
  final num numRate;
  final String rateText;
  final String status;
  final bool favorite;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String hour;
  final String description;
  final String priceRange;
  final List<ImageModel> photo;
  final List<HourModel> hourDetail;
  final List<IconModel> service;
  final List<ProductModel> feature;
  final List<ProductModel> related;
  final LocationModel location;
  final UserModel author;
  final DetailViewStyle viewStyle;

  ProductModel({
    this.id,
    this.title,
    this.subtitle,
    this.image,
    this.createDate,
    this.rate,
    this.numRate,
    this.rateText,
    this.status,
    this.favorite,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.hour,
    this.description,
    this.priceRange,
    this.hourDetail,
    this.service,
    this.photo,
    this.feature,
    this.related,
    this.location,
    this.author,
    this.viewStyle,
  });

  static DetailViewStyle _setViewStyle(json) {
    if ((json['tab'] as List ?? []).isNotEmpty) {
      return DetailViewStyle.tab;
    }
    return DetailViewStyle.basic;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProductModel(
      id: json['_id'] ?? "0",
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
      createDate: json['created_date'] ?? 'Unknown',
      rate: json['rate'] ?? 0,
      numRate: json['num_rate'] ?? 0,
      rateText: json['rate_text'] ?? 'Unknown',
      status: json['status'] ?? '',
      favorite: json['favorite'] ?? false,
      address: json['address'] ?? 'Unknown',
      phone: json['phone'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      website: json['website'] ?? 'Unknown',
      hour: json['hour'] ?? 'Unknown',
      description: json['description'] ?? 'Unknown',
      priceRange: json['price_range'] ?? 'Unknown',
      hourDetail: (json['hour_detail'] as List ?? []).map((item) {
        return HourModel.fromJson(item);
      }).toList(),
      service: (json['service'] as List ?? []).map((item) {
        return IconModel.fromJson(item);
      }).toList(),
      photo: (json['photo'] as List ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      feature: (json['feature'] as List ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
      related: (json['related'] as List ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
      location: LocationModel.fromJson(json['location']),
      author: UserModel.fromJson(json['auther']),
      viewStyle: _setViewStyle(json),
    );
  }
}
