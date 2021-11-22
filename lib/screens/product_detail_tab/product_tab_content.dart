import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TabContent extends StatelessWidget {
  final TabModel item;
  final ProductDetailPageModel page;
  final Function(ProductModel) onProductDetail;

  TabContent({
    Key key,
    this.item,
    this.page,
    this.onProductDetail,
  }) : super(key: key);

  ///Make action
  Future<void> _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (item.title) {
      case 'information':
        return Container(
          key: item.keyContentItem,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  Translate.of(context).translate(item.title),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  _makeAction(
                    'https://www.google.com/maps/search/?api=1&query=${page.product.location.lat},${page.product.location.long}',
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).dividerColor,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('address'),
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                          ),
                          Text(
                            page?.product?.address,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _makeAction('tel:${page.product.phone}');
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).dividerColor,
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('phone'),
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                          ),
                          Text(
                            page?.product?.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _makeAction('mailto:${page.product.email}');
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).dividerColor,
                      ),
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('email'),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            page?.product?.email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _makeAction(page.product.website);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).dividerColor,
                      ),
                      child: Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('website'),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            page?.product?.website,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).dividerColor,
                          ),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate('open_time'),
                                style: Theme.of(context).textTheme.caption,
                                maxLines: 1,
                              ),
                              Text(
                                page?.product?.hour,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = page.product.hourDetail[index];
                  return Container(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate(item.title),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          item.time == 'day_off'
                              ? Translate.of(context).translate('day_off')
                              : item.time,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: page.product.hourDetail.length,
              ),
              SizedBox(height: 16),
              Text(
                page?.product?.description,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      height: 1.3,
                    ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('date_established'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            page?.product?.createDate,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('price_range'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            page?.product?.priceRange,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );

      case 'facilities':
        return Container(
          key: item.keyContentItem,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('facilities'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: page.product.service.map((item) {
                    return IntrinsicWidth(
                      child: AppTag(
                        item.title,
                        type: TagType.chip,
                        icon: Icon(
                          UtilIcon.getIconData(item.icon),
                          size: 12,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Divider(),
            ],
          ),
        );

      case 'featured':
        return Container(
          key: item.keyContentItem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Text(
                  Translate.of(context).translate('featured'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16),
                  itemBuilder: (context, index) {
                    final ProductModel item = page?.product?.feature[index];
                    return Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.only(right: 16),
                      child: AppProductItem(
                        onPressed: onProductDetail,
                        item: item,
                        type: ProductViewType.gird,
                      ),
                    );
                  },
                  itemCount: page.product.feature.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Divider(),
              ),
            ],
          ),
        );

      case 'nearly':
        return Container(
          key: item.keyContentItem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Text(
                  Translate.of(context).translate('nearly'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 145,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16),
                  itemBuilder: (context, index) {
                    final ProductModel item = page?.product?.feature[index];
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(right: 16),
                      child: AppProductItem(
                        onPressed: onProductDetail,
                        item: item,
                        type: ProductViewType.list,
                      ),
                    );
                  },
                  itemCount: page.product.feature.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Divider(),
              ),
            ],
          ),
        );

      case 'related':
        return Container(
          key: item.keyContentItem,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    Translate.of(context).translate('related'),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Column(
                  children: page.product.related.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: AppProductItem(
                        onPressed: onProductDetail,
                        item: item,
                        type: ProductViewType.small,
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        );

      default:
        return Container(
          key: item.keyContentItem,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  Translate.of(context).translate(item.title),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 200,
                child: Placeholder(),
              )
            ],
          ),
        );
    }
  }
}
