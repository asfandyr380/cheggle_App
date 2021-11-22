import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';

class ListRepository {
  ///List Sort support in Application
  final List<SortModel> listSortDefault = [
    {
      "code": "lasted",
      "name": "lasted_post",
      "icon": Icons.swap_vert,
    },
    {
      "code": "oldest",
      "name": "oldest_post",
      "icon": Icons.swap_vert,
    },
    {
      "code": "most_view",
      "name": "most_view",
      "icon": Icons.swap_vert,
    },
    {
      "code": "rating",
      "name": "review_rating",
      "icon": Icons.swap_vert,
    },
  ].map((item) => SortModel.fromJson(item)).toList();

  ///Singleton factory
  static final ListRepository _instance = ListRepository._internal();

  factory ListRepository() {
    return _instance;
  }

  ListRepository._internal();
}
