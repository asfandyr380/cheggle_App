import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/model_category.dart';

import 'app_placeholder.dart';

class RecommendationCard extends StatelessWidget {
  final Function onPressed;
  final CategoryModel item;
  final Color textColor;
  const RecommendationCard({this.item, this.onPressed, this.textColor});

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: Container(
          height: 80,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey, width: 3),
          ),
          child: Center(
            child: Container(
              height: 10,
              width: 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.grey.shade400, width: 3),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(Colors.black.withAlpha(80), BlendMode.darken),
            image: NetworkImage("$BASE_URL_Img/${item.image}"),
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade400),
            child: Text(
              item.title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
