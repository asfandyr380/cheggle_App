import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class AppBarHomeFood extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final List<CountryModel> country;
  final CountryModel countrySelected;
  final VoidCallback onNotification;
  final VoidCallback onLocation;

  AppBarHomeFood({
    this.maxHeight,
    this.minHeight,
    this.country,
    this.countrySelected,
    this.onNotification,
    this.onLocation,
  });

  ///Build Action
  Widget _buildAction(BuildContext context) {
    if (country != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onLocation,
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    countrySelected.name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          InkWell(
            onTap: onNotification,
            child: Stack(
              children: [
                Icon(Icons.notifications_none_outlined),
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
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 1.5),
    );
  }

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    double marginSearch = 16 + shrinkOffset;
    if (marginSearch >= 56) {
      marginSearch = 56;
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
                  child: _buildAction(context),
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
                              'search_event',
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
