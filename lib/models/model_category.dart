import 'package:flutter/cupertino.dart';
import 'package:listar_flutter/utils/utils.dart';

class CategoryModel {
  final String id;
  final String title;
  final int count;
  final String image;
  final IconData icon;
  final Color color;

  CategoryModel({
    this.id,
    this.title,
    this.count,
    this.image,
    this.icon,
    this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    final icon = UtilIcon.getIconData(json['icon'] ?? "Unknown");
    final color = UtilColor.getColorFromHex(json['color'] ?? "#ff8a65");
    return CategoryModel(
      id: json['id'] ?? "0",
      title: json['title'] ?? 'Unknown',
      count: json['count'] ?? 0,
      image: json['image'] ?? 'Unknown',
      icon: icon,
      color: color,
    );
  }
}
