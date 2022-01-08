import 'dart:developer';

import 'package:listar_flutter/models/model.dart';

class UserModel {
  final String id;
  final String person;
  final String firstName;
  final String lastName;
  final String phone;
  final String fax;
  final String mobile;
  final String website;
  final String email;
  final String companyName;
  final String b1;
  final String b2;
  final String address;
  final String postal;
  final String city;
  final String district;
  final String country;
  final String image;
  final String aboutUs;
  final String facebook_link;
  final String instagram_link;
  final String twitter_link;
  final String linkdIn_link;
  final String name;
  final num rate;
  final String hour;
  final List<ProductModel> wishlist;
  final List roles;
  final List<CommentModel> reviews;
  final List servies;
  final List partners;
  final LocationModel location;
  final List<HourModel> hour_details;
  final List pricing_list;
  final List menu_list;
  final String token;

  UserModel(
    this.id,
    this.person,
    this.firstName,
    this.lastName,
    this.phone,
    this.fax,
    this.mobile,
    this.website,
    this.email,
    this.companyName,
    this.b1,
    this.b2,
    this.address,
    this.postal,
    this.city,
    this.district,
    this.country,
    this.image,
    this.aboutUs,
    this.facebook_link,
    this.twitter_link,
    this.instagram_link,
    this.linkdIn_link,
    this.name,
    this.rate,
    this.hour,
    this.wishlist,
    this.roles,
    this.reviews,
    this.servies,
    this.partners,
    this.location,
    this.hour_details,
    this.pricing_list,
    this.menu_list,
    this.token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json, {bool addReview}) {
    bool _addReview = addReview ?? false;
    if (json == null) return null;
    return UserModel(
      json['id'] ?? json['_id'] ?? '0',
      json['person'] ?? "Unknown",
      json["firstname"] ?? "Unknown",
      json["lastname"] ?? "Unknown",
      json["phone"] ?? "Unknown",
      json["fax"] ?? "Unknown",
      json["mobile"] ?? "Unknown",
      json["website"] ?? "Unknown",
      json["email"] ?? "Unknown",
      json["company"] ?? "Unknown",
      json["b1"] ?? "Unknown",
      json["b2"] ?? "Unknown",
      json["address"] ?? "Unknown",
      json["postal"] ?? "Unknown",
      json["city"] ?? "Unknown",
      json["district"] ?? "Unknown",
      json["country"] ?? "Unknown",
      json["photo"] ?? "Unknown",
      json['aboutUs'] ?? "Unknown",
      json['facebook'] ?? "Unknown",
      json['twitter'] ?? "Unknown",
      json['instagram'] ?? "Unknown",
      json['linkdin'] ?? "Unknown",
      json["full_name"] ?? "Unknown",
      json['rate'] ?? 0,
      json['hour'] ?? "Unknown",
      (json['wishlist'] as List ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
      json["roles"] ?? [],
      _addReview
          ? (json['reviews'] as List ?? []).map((item) {
              return CommentModel.fromJson(item);
            }).toList()
          : <CommentModel>[],
      json['services'] ?? [],
      json['partners'] ?? [],
      LocationModel.fromJson(json['location']),
      (json['hour_details'] as List ?? []).map((item) {
        return HourModel.fromJson(item);
      }).toList(),
      json['pricing_list'] ?? [],
      json['menu_list'] ?? [],
      json["token"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person': person,
      'firstname': firstName,
      'lastname': lastName,
      'phone': phone,
      'fax': fax,
      'mobile': mobile,
      'website': website,
      'email': email,
      'company': companyName,
      'b1': b1,
      'b2': b2,
      'address': address,
      'postal': postal,
      'city': city,
      'district': district,
      'country': country,
      'photo': image,
      'aboutUs': aboutUs,
      'facebook': facebook_link,
      'twitter': twitter_link,
      'instagram': instagram_link,
      'linkdin': linkdIn_link,
      'full_name': name,
      'rate': rate,
      'hour': hour,
      'wishlist': wishlist,
      'roles': roles,
      'reviews': reviews,
      'services': servies,
      'partners': partners,
      'location': location,
      'hour_details': hour_details,
      'token': token,
    };
  }
}
