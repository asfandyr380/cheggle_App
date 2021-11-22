import 'package:flutter/material.dart';

class TabModel {
  final GlobalKey keyContentItem;
  final GlobalKey keyTabItem;
  final String title;

  TabModel({
    this.keyContentItem,
    this.keyTabItem,
    this.title,
  });

  factory TabModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TabModel(
      keyContentItem: GlobalKey(),
      keyTabItem: GlobalKey(),
      title: json['title'] ?? 'Unknown',
    );
  }
}
