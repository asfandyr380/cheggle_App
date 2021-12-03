import 'package:listar_flutter/models/model.dart';

class ProductRealEstateModel {
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
  final String description;
  final double price;
  final List<ImageModel> photo;
  final List<IconModel> service;
  final List<ProductRealEstateModel> nearly;
  final LocationModel location;
  final UserModel author;

  ProductRealEstateModel({
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
    this.description,
    this.price,
    this.service,
    this.photo,
    this.nearly,
    this.location,
    this.author,
  });

  factory ProductRealEstateModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProductRealEstateModel(
      id: json['id'] ?? '0',
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
      description: json['description'] ?? 'Unknown',
      price: json['price'] ?? 0.0,
      service: (json['service'] as List ?? []).map((item) {
        return IconModel.fromJson(item);
      }).toList(),
      photo: (json['photo'] as List ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      nearly: (json['nearly'] as List ?? []).map((item) {
        return ProductRealEstateModel.fromJson(item);
      }).toList(),
      location: LocationModel.fromJson(json['location']),
      author: UserModel.fromJson(json['author']),
    );
  }
}
