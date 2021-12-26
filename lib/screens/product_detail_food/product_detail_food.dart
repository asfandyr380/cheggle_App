import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailFood extends StatefulWidget {
  ProductDetailFood({Key key, this.id = "0"}) : super(key: key);

  final String id;

  @override
  _ProductDetailFoodState createState() {
    return _ProductDetailFoodState();
  }
}

class _ProductDetailFoodState extends State<ProductDetailFood> {
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  bool _favorite = false;
  ProductDetailFoodPageModel _detailPage;

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
        _detailPage = ProductDetailFoodPageModel.fromJson(result.data);
        _favorite = _detailPage?.product?.favorite;
        final markerID = MarkerId(_detailPage?.product?.id.toString());
        final marker = Marker(
          markerId: markerID,
          position: LatLng(
            _detailPage?.product?.location?.lat,
            _detailPage?.product?.location?.long,
          ),
          infoWindow: InfoWindow(title: _detailPage?.product?.title),
        );
        _markers[markerID] = marker;
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

  ///On Share
  void _onShare() async {
    await Share.share(
      'https://codecanyon.net/item/listar-flux-mobile-directory-listing-app-template-for-flutter/25559387',
      subject: 'Listar Flux',
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductFoodModel item) {
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

  ///On navigate chat screen
  void _onChat() {
    Navigator.pushNamed(context, Routes.chat, arguments: 3);
  }

  ///Make action
  Future<void> _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  ///Build Card
  Widget _buildCard() {
    if (_detailPage != null) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: ProductDetailSwipe(
              images: _detailPage?.product?.photo,
              alignment: Alignment(0.0, 0.4),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            padding: EdgeInsets.all(16),
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _detailPage.product.title,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _detailPage.product.status,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: _onReview,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${_detailPage.product.rate}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          Text(
                            _detailPage.product.distance,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          Text(
                            _detailPage.product.subtitle,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _detailPage.product.promotion,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        _favorite ? Icons.favorite : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: _onLike,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }

    return Container();
  }

  ///Build Content
  Widget _buildContent() {
    if (_detailPage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(_detailPage.product.author.image),
                        ),
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _detailPage.product.author.name,
                            style: Theme.of(context).textTheme.button,
                          ),
                          SizedBox(height: 4),
                          Text(
                            _detailPage.product.author.address,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: _onChat,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                      ),
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      _makeAction('tel:${_detailPage.product.phone}');
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                      ),
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text(
            Translate.of(context).translate('related'),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            Translate.of(context).translate('let_find_interesting'),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = _detailPage.product.related[index];
              return AppProductFoodItem(
                item: item,
                onPressed: _onProductDetail,
                type: ProductViewType.small,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
            itemCount: _detailPage.product.related.length ?? 0,
          ),
        ],
      );
    }

    ///Loading
    return AppPlaceholder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
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
            expandedHeight: 260.0,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share_outlined),
                onPressed: _onShare,
              ),
              IconButton(
                icon: Icon(Icons.photo_library_outlined),
                onPressed: _onPhotoPreview,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Theme.of(context).backgroundColor,
                child: _buildCard(),
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(16),
                  child: _buildContent(),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
