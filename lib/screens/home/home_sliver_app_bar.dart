import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/home/home_swiper.dart';
import 'package:listar_flutter/utils/utils.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<ImageModel> banners;

  AppBarHomeSliver({this.expandedHeight, this.banners});

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: HomeSwipe(
            images: banners,
            height: expandedHeight,
          ),
        ),
        Container(
          height: 36,
          color: Theme.of(context).backgroundColor,
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 3,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.searchHistory);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              Translate.of(context).translate(
                                'search_location',
                              ),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: VerticalDivider(),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
