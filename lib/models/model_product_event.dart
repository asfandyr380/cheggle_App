import 'package:listar_flutter/models/model.dart';

class ProductEventModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
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
  final DateTime date;
  final String time;
  final List<ImageModel> photo;
  final List<UserModel> liked;
  final List<ProductEventModel> nearly;
  final LocationModel location;
  final UserModel author;

  ProductEventModel({
    this.id,
    this.title,
    this.subtitle,
    this.image,
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
    this.date,
    this.time,
    this.photo,
    this.liked,
    this.nearly,
    this.location,
    this.author,
  });

  factory ProductEventModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProductEventModel(
      id: json['id'] ?? '0',
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
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
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      time: json['time'] ?? 'Unknown',
      liked: (json['liked'] as List ?? []).map((item) {
        return UserModel.fromJson(item);
      }).toList(),
      photo: (json['photo'] as List ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      nearly: (json['nearly'] as List ?? []).map((item) {
        return ProductEventModel.fromJson(item);
      }).toList(),
      location: LocationModel.fromJson(json['location']),
      author: UserModel.fromJson(json['author']),
    );
  }
}
