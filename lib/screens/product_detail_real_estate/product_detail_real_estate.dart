import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailRealEstate extends StatefulWidget {
  ProductDetailRealEstate({Key key, this.id = 0}) : super(key: key);

  final num id;

  @override
  _ProductDetailRealEstateState createState() {
    return _ProductDetailRealEstateState();
  }
}

class _ProductDetailRealEstateState extends State<ProductDetailRealEstate> {
  final _currency = String.fromCharCode(0x24);

  CameraPosition _initPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  bool _favorite = false;
  ProductDetailRealEstatePageModel _detailPage;

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
        _detailPage = ProductDetailRealEstatePageModel.fromJson(result.data);
        _favorite = _detailPage?.product?.favorite;
        _initPosition = CameraPosition(
          target: LatLng(
            _detailPage?.product?.location?.lat,
            _detailPage?.product?.location?.long,
          ),
          zoom: 15.4746,
        );
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
  void _onProductDetail(ProductRealEstateModel item) {
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

  ///Build Content
  Widget _buildContent() {
    if (_detailPage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _detailPage.product.subtitle,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '$_currency${_detailPage.product.price}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(height: 8),
          Text(
            _detailPage.product.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            _detailPage.product.address,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              AppTag(
                "${_detailPage.product.rate}",
                type: TagType.rateSmall,
                onPressed: _onReview,
              ),
              SizedBox(width: 4),
              InkWell(
                onTap: _onReview,
                child: RatingBar.builder(
                onRatingUpdate: (_){},
                  initialRating: _detailPage?.product?.rate,
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
              ),
              SizedBox(width: 4),
              Text(
                '(${_detailPage.product.numRate})',
                style: Theme.of(context).textTheme.caption,
              )
            ],
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
                            _detailPage.product.author.description,
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
            Translate.of(context).translate('facilities'),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _detailPage.product.service.map((item) {
              return IntrinsicWidth(
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                      ),
                      child: Icon(
                        UtilIcon.getIconData(item.icon),
                        size: 14,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      item.title,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Theme.of(context).accentColor),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Text(
            Translate.of(context).translate('description'),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            _detailPage.product.description,
            style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.3),
          ),
          SizedBox(height: 16),
          Container(
            height: 180,
            child: GoogleMap(
              initialCameraPosition: _initPosition,
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(_markers.values),
            ),
          ),
          SizedBox(height: 16),
          Text(
            Translate.of(context).translate('nearly'),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            Translate.of(context).translate('let_find_more_location'),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = _detailPage.product.nearly[index];
              return AppProductRealEstateItem(
                item: item,
                onPressed: _onProductDetail,
                type: ProductViewType.cardLarge,
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Divider(),
              );
            },
            itemCount: _detailPage.product.nearly.length ?? 0,
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
            expandedHeight: 200.0,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border),
                onPressed: _onLike,
              ),
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
              background: ProductDetailSwipe(
                images: _detailPage?.product?.photo,
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
