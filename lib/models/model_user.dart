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
  final List roles;
  final String name;
  final String token;
  final List<CommentModel> reviews;
  final List servies;
  final String aboutUs;
  final List partners;
  final String facebook_link;
  final String instagram_link;
  final String twitter_link;
  final String linkdIn_link;

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
    this.roles,
    this.name,
    this.token,
    this.reviews,
    this.servies,
    this.aboutUs,
    this.partners,
    this.facebook_link,
    this.instagram_link,
    this.linkdIn_link,
    this.twitter_link,
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
      json["roles"] ?? [],
      json["full_name"] ?? "Unknown",
      json["token"] ?? "Unknown",
      _addReview
          ? (json['reviews'] as List ?? []).map((item) {
              return CommentModel.fromJson(item);
            }).toList()
          : <CommentModel>[],
      json['services'] ?? [],
      json['aboutUs'] ?? "Unknown",
      json['partners'] ?? [],
      json['facebook'] ?? "Unknown",
      json['instagram'] ?? "Unknown",
      json['linkdin'] ?? "Unknown",
      json['twitter'] ?? "Unknown",
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
      'roles': roles,
      'full_name': name,
      'reviews': reviews,
      'services': servies,
      'aboutUs': aboutUs,
      'partners': partners,
      'facebook': facebook_link,
      'twitter': twitter_link,
      'instagram': instagram_link,
      'linkdin': linkdIn_link,
      'token': token,
    };
  }
}
