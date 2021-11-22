import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';

class AppBarHomeEvent extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final DateTime today;
  final VoidCallback onPressed;

  AppBarHomeEvent({
    this.maxHeight,
    this.minHeight,
    this.today,
    this.onPressed,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    double marginSearch = 16 + shrinkOffset;
    if (marginSearch >= 70) {
      marginSearch = 70;
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              'EEE MMM d yyyy',
                              AppLanguage.defaultLanguage.languageCode,
                            ).format(today),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hello Steve Garrett',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: onPressed,
                        child: Stack(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(Images.Profile2),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              right: 1,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: EdgeInsets.only(
              bottom: 8,
              top: 8,
              left: 16,
              right: marginSearch,
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).cardColor,
                ),
                child: IntrinsicHeight(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.searchHistory);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            Translate.of(context).translate(
                              'Find events near you',
                            ),
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
        )
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
