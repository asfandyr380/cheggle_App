import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.id = '0'}) : super(key: key);

  final String id;

  @override
  _ProductDetailState createState() {
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetail> {
  bool _favorite = false;
  bool _showHour = false;
  ProductDetailPageModel _detailPage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    
    final ResultApiModel result = await Api.getProductDetail(id: widget.id);
    if (result.success) {
      setState(() {
        _detailPage = ProductDetailPageModel.fromJson(result.data);
        _favorite = _detailPage?.product?.favorite;
      });
    }
  }

  ///On navigate gallery
  void _onPhotoPreview() {
    Navigator.pushNamed(
      context,
      Routes.gallery,
      arguments: _detailPage?.product?.photo,
    );
  }

  ///On navigate map
  void _onLocation() {
    Navigator.pushNamed(
      context,
      Routes.location,
      arguments: _detailPage?.product?.location,
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On navigate review
  void _onReview() {
    Navigator.pushNamed(context, Routes.review);
  }

  ///On like product
  void _onLike() {
    setState(() {
      _favorite = !_favorite;
    });
  }

  ///Make action
  Future<void> _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  ///Build banner UI
  Widget _buildBanner() {
    if (_detailPage?.product?.image == null) {
      return AppPlaceholder(
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Image.asset(
      _detailPage?.product?.image,
      fit: BoxFit.cover,
    );
  }

  ///Build info
  Widget _buildInfo() {
    if (_detailPage == null) {
      return AppPlaceholder(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
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
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Container(height: 10, width: 50, color: Colors.white),
              )
            ],
          ),
        ),
      );
    }

    Widget status = Container();
    if (_detailPage.product.status.isNotEmpty) {
      status = AppTag(
        _detailPage?.product?.status,
        type: TagType.status,
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _detailPage?.product?.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(
                  _favorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: _onLike,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: _onReview,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _detailPage?.product?.subtitle,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppTag(
                          "${_detailPage?.product?.rate}",
                          type: TagType.rateSmall,
                        ),
                        SizedBox(width: 4),
                        RatingBar.builder(
                          onRatingUpdate: (_){},
                          initialRating: _detailPage?.product?.rate.toDouble(),
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
                          "(${_detailPage?.product?.numRate})",
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
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              _makeAction(
                'https://www.google.com/maps/search/?api=1&query=${_detailPage.product.location.lat},${_detailPage.product.location.long}',
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
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage?.product?.address,
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
              _makeAction('tel:${_detailPage.product.phone}');
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
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage?.product?.phone,
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
              _makeAction('mailto:${_detailPage.product.email}');
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
                        _detailPage?.product?.email,
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
              _makeAction(_detailPage.product.website);
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
                        _detailPage?.product?.website,
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
              setState(() {
                _showHour = !_showHour;
              });
            },
            child: Row(
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
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('open_time'),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              _detailPage?.product?.hour,
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
                Icon(
                  _showHour
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Visibility(
            visible: _showHour,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = _detailPage.product.hourDetail[index];
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
              itemCount: _detailPage.product.hourDetail.length,
            ),
          ),
          SizedBox(height: 16),
          Text(
            _detailPage?.product?.description,
            style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.3),
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
                        _detailPage?.product?.createDate,
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
                        _detailPage?.product?.priceRange,
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
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    Translate.of(context).translate('facilities'),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _detailPage.product.service.map((item) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Build list feature
  Widget _buildFeature() {
    if (_detailPage?.product?.feature == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
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
                final ProductModel item = _detailPage.product.feature[index];
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(right: 16),
                  child: AppProductItem(
                    onPressed: _onProductDetail,
                    item: item,
                    type: ProductViewType.gird,
                  ),
                );
              },
              itemCount: _detailPage.product.feature.length,
            ),
          )
        ],
      ),
    );
  }

  ///Build list related
  Widget _buildRelated() {
    if (_detailPage?.product?.related == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              Translate.of(context).translate('related'),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: _detailPage.product.related.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: AppProductItem(
                  onPressed: _onProductDetail,
                  item: item,
                  type: ProductViewType.small,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.map),
                onPressed: _onLocation,
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: _onPhotoPreview,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: AppUserInfo(
                        user: _detailPage?.product?.author,
                        onPressed: () {},
                        type: AppUserType.basic,
                      ),
                    ),
                    _buildInfo(),
                    _buildFeature(),
                    _buildRelated()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
