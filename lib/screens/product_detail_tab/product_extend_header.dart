import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ProductHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final ProductDetailPageModel productTabPage;
  final bool like;
  final VoidCallback onPressLike;
  final VoidCallback onPressReview;

  ProductHeader({
    this.height,
    this.productTabPage,
    this.like,
    this.onPressLike,
    this.onPressReview,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    ///Build info
    Widget information() {
      if (productTabPage == null) {
        return AppPlaceholder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 16,
                  top: 16,
                ),
                height: 10,
                width: 150,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        );
      }

      Widget status = Container();
      if (productTabPage.product.status.isNotEmpty) {
        status = AppTag(
          productTabPage.product.status,
          type: TagType.status,
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                productTabPage?.product?.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(
                  like ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: onPressLike,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: onPressReview,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productTabPage?.product?.subtitle,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppTag(
                          "${productTabPage?.product?.rate}",
                          type: TagType.rateSmall,
                        ),
                        SizedBox(width: 4),
                        RatingBar.builder(
                          onRatingUpdate: (_) {},
                          initialRating: productTabPage?.product?.rate.toDouble(),
                          minRating: 1,
                          allowHalfRating: true,
                          unratedColor: Colors.amber.withAlpha(100),
                          itemCount: 5,
                          itemSize: 14.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "(${productTabPage?.product?.numRate})",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              status,
            ],
          ),
        ],
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          children: <Widget>[
            AppUserInfo(
              user: productTabPage?.product?.author,
              onPressed: () {},
              type: AppUserType.basic,
            ),
            information(),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
