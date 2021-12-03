import 'package:listar_flutter/models/model.dart';

class ProductFoodModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final num rate;
  final num numRate;
  final String rateText;
  final String status;
  final String promotion;
  final String distance;
  final bool favorite;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String description;
  final List<ImageModel> photo;
  final List<ProductFoodModel> related;
  final LocationModel location;
  final UserModel author;

  ProductFoodModel({
    this.id,
    this.title,
    this.subtitle,
    this.image,
    this.rate,
    this.numRate,
    this.rateText,
    this.status,
    this.promotion,
    this.distance,
    this.favorite,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.description,
    this.photo,
    this.related,
    this.location,
    this.author,
  });

  factory ProductFoodModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProductFoodModel(
      id: json['id'] ?? '0',
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
      rate: json['rate'] ?? 0,
      numRate: json['num_rate'] ?? 0,
      rateText: json['rate_text'] ?? 'Unknown',
      status: json['status'] ?? '',
      promotion: json['promotion'] ?? '',
      distance: json['distance'] ?? '',
      favorite: json['favorite'] ?? false,
      address: json['address'] ?? 'Unknown',
      phone: json['phone'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      website: json['website'] ?? 'Unknown',
      description: json['description'] ?? 'Unknown',
      photo: (json['photo'] as List ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      related: (json['related'] as List ?? []).map((item) {
        return ProductFoodModel.fromJson(item);
      }).toList(),
      location: LocationModel.fromJson(json['location']),
      author: UserModel.fromJson(json['author']),
    );
  }
}
