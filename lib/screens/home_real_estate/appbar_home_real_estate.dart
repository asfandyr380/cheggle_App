import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class AppBarHomeRealEstate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final List<CountryModel> country;
  final CountryModel countrySelected;
  final VoidCallback onPressed;

  AppBarHomeRealEstate({
    this.maxHeight,
    this.minHeight,
    this.country,
    this.countrySelected,
    this.onPressed,
  });

  ///Build action show modal
  Widget _buildAction(BuildContext context) {
    if (country == null) {
      return AppPlaceholder(
        child: Column(
          children: [
            Text(
              Translate.of(context).translate('loading'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              children: [
                Text(
                  Translate.of(context).translate('loading'),
                  style: Theme.of(context).textTheme.caption,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 14,
                )
              ],
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            countrySelected.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
            children: [
              Text(
                Translate.of(context).translate('select_location'),
                style: Theme.of(context).textTheme.caption,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 16,
                color: Theme.of(context).primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    double marginSearch = 16 + shrinkOffset;
    if (marginSearch >= 135) {
      marginSearch = 135;
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
                      Text(
                        "RealEstate",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      _buildAction(context),
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
                              'search_real_estate',
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
