import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

import 'appbar_home_food.dart';

class HomeFood extends StatefulWidget {
  HomeFood({Key key}) : super(key: key);

  @override
  _HomeFoodState createState() {
    return _HomeFoodState();
  }
}

class _HomeFoodState extends State<HomeFood> {
  HomeFoodPageModel _homePage;
  BusinessState _business = AppBloc.businessCubit.state;
  CountryModel _countrySelected;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final result = await Api.getHome();
    if (result.success) {
      setState(() {
        _homePage = HomeFoodPageModel.fromJson(result.data);
        if (_homePage.country.length > 0) {
          _countrySelected = _homePage.country[0];
        }
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _loadData();
  }

  ///On navigate list product
  void _onProductList(CategoryModel item) {
    Navigator.pushNamed(
      context,
      Routes.listProduct,
      arguments: item?.title ?? "List",
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductFoodModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On navigate notification
  void _onNotification() {
    Navigator.pushNamed(context, Routes.notification);
  }

  ///Choose Business
  void _chooseBusiness() async {
    final result = await showDialog<BusinessState>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        _business = AppBloc.businessCubit.state;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                Translate.of(context).translate('choose_your_business'),
              ),
              content: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 8,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.basic;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.basic),
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: AssetImage(Images.Location1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Basic",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.realEstate;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.realEstate),
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: AssetImage(Images.RealEstate1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Real Estate",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.event;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.event),
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: AssetImage(Images.Event1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Event",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.food;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.food),
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: AssetImage(Images.Food1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Food",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                AppButton(
                  Translate.of(context).translate('close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  type: ButtonType.text,
                ),
                AppButton(
                  Translate.of(context).translate('apply'),
                  onPressed: () {
                    Navigator.pop(context, _business);
                  },
                )
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      AppBloc.businessCubit.onChangeBusiness(_business);
    }
  }

  ///Show modal select country
  Future<void> _onSelectCountry() async {
    final item = await showModalBottomSheet<CountryModel>(
      context: context,
      builder: (BuildContext context) {
        return HomeCountryList(
          country: _homePage?.country,
          countrySelected: _countrySelected,
          onSelect: (item) {
            Navigator.pop(context, item);
          },
        );
      },
    );
    if (item != null) {
      setState(() {
        _countrySelected = item;
      });
    }
  }

  ///Is Selected Business
  Color _exportColor(BusinessState business) {
    if (business == _business) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).dividerColor;
  }

  ///Build Banner
  Widget _buildBanner() {
    Widget content = AppPlaceholder(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
    if (_homePage != null) {
      content = Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            final item = _homePage.banners[index];
            return AppProductFoodItem(
              item: item,
              type: ProductViewType.cardLarge,
              onPressed: _onProductDetail,
            );
          },
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: false,
          autoplay: true,
          itemCount: _homePage.banners.length,
          pagination: SwiperPagination(
            alignment: Alignment(0.0, 1.0),
            builder: DotSwiperPaginationBuilder(
              activeColor: Theme.of(context).primaryColor,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 135,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: content,
    );
  }

  ///Build category
  Widget _buildCategory() {
    Widget content = ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AppPlaceholder(
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 8,
    );
    if (_homePage?.category != null) {
      content = ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage.category[index];
          return Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: InkWell(
              onTap: () {
                _onProductList(item);
              },
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.button,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _homePage.category.length,
      );

      ///Empty
      if (_homePage.category.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('data_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            Translate.of(context).translate('explore_by_category'),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 104,
          child: content,
        ),
      ],
    );
  }

  ///Build Feature List
  Widget _buildRecommend() {
    Widget content = ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          padding: EdgeInsets.only(left: 8, right: 8),
          child: AppProductEventItem(
            type: ProductViewType.gird,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage?.recommends != null) {
      content = ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage.recommends[index];
          return Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            width: 200,
            child: AppProductFoodItem(
              item: item,
              onPressed: _onProductDetail,
              type: ProductViewType.gird,
            ),
          );
        },
        itemCount: _homePage.recommends.length,
      );

      ///Empty
      if (_homePage.recommends.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('data_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            Translate.of(context).translate('recommend_for_you'),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 208,
          child: content,
        )
      ],
    );
  }

  ///Build Promotion banner
  Widget _buildPromotion() {
    Widget content = AppPlaceholder(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
    if (_homePage?.promotion != null) {
      content = Container(
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_homePage.promotion.image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translate.of(context).translate(
                      _homePage.promotion.title,
                    ),
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    Translate.of(context).translate('let_find_interesting'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  _onProductList(null);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    Translate.of(context).translate('see_more'),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(16),
      child: content,
    );
  }

  ///Build recent
  Widget _buildRecent() {
    Widget content = ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 16, right: 16),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppProductEventItem(
            type: ProductViewType.small,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage?.locations != null) {
      content = ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          final item = _homePage.locations[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppProductFoodItem(
              item: item,
              onPressed: _onProductDetail,
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: _homePage.locations.length,
      );

      ///Empty
      if (_homePage.locations.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('data_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate('recent_location'),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                Translate.of(context).translate('let_find_best_price'),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        content,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeFood(
              maxHeight: 120 + MediaQuery.of(context).padding.top,
              minHeight: 60 + MediaQuery.of(context).padding.top,
              country: _homePage?.country,
              countrySelected: _countrySelected,
              onNotification: _onNotification,
              onLocation: _onSelectCountry,
            ),
            pinned: true,
            floating: true,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 12),
                _buildBanner(),
                _buildCategory(),
                _buildRecommend(),
                _buildPromotion(),
                _buildRecent(),
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        tooltip: "More",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _chooseBusiness,
      ),
    );
  }
}
