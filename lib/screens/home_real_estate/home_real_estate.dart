import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

import '../../widgets/home_country_list.dart';
import 'appbar_home_real_estate.dart';

class HomeRealEstate extends StatefulWidget {
  HomeRealEstate({Key key}) : super(key: key);

  @override
  _HomeRealEstateState createState() {
    return _HomeRealEstateState();
  }
}

class _HomeRealEstateState extends State<HomeRealEstate> {
  HomeRealEstatePageModel _homePage;
  BusinessState _business = AppBloc.businessCubit.state;
  CountryModel _countrySelected;

  @override
  void initState() {
    super.initState();
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

  ///Fetch API
  Future<void> _loadData() async {
    final result = await Api.getHome();
    if (result.success) {
      setState(() {
        _homePage = HomeRealEstatePageModel.fromJson(result.data);
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

  ///On navigate product detail
  void _onProductDetail(ProductRealEstateModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
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

  ///Is Selected Business
  Color _exportColor(BusinessState business) {
    if (business == _business) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).dividerColor;
  }

  ///Build Location
  Widget _buildLocation() {
    Widget content = ListView.separated(
      padding: EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AppPlaceholder(
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  Translate.of(context).translate('loading'),
                  style: Theme.of(context).textTheme.button,
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 4);
      },
      itemCount: 8,
    );
    if (_homePage?.location != null) {
      content = ListView.separated(
        padding: EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage.location[index];
          return Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: InkWell(
              onTap: () {
                _onProductList(item);
              },
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
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
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 4);
        },
        itemCount: _homePage.location.length,
      );

      ///Empty
      if (_homePage.location.isEmpty) {
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
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      height: 84,
      child: content,
    );
  }

  ///Build Popular
  Widget _buildPopular() {
    Widget content = ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          padding: EdgeInsets.only(left: 8, right: 8),
          child: AppProductRealEstateItem(
            type: ProductViewType.gird,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage?.popular != null) {
      content = ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage?.popular[index];
          return Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            width: 200,
            child: AppProductRealEstateItem(
              item: item,
              onPressed: _onProductDetail,
              type: ProductViewType.gird,
            ),
          );
        },
        itemCount: _homePage.popular.length,
      );

      ///Empty
      if (_homePage.popular.isEmpty) {
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
                Translate.of(context).translate('popular_nearest'),
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
        Container(
          height: 228,
          child: content,
        )
      ],
    );
  }

  ///Build Recommend
  Widget _buildRecommend() {
    Widget content = ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 16, right: 16),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppProductRealEstateItem(
            type: ProductViewType.list,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage?.recommend != null) {
      content = ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          final item = _homePage.recommend[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppProductRealEstateItem(
              item: item,
              onPressed: _onProductDetail,
              type: ProductViewType.list,
            ),
          );
        },
        itemCount: _homePage.recommend.length,
      );

      ///Empty
      if (_homePage.recommend.isEmpty) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate('recommend_for_you'),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('let_find_best_price'),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  InkWell(
                    onTap: () {
                      _onProductList(null);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        Translate.of(context).translate('view_all'),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                    ),
                  )
                ],
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
            delegate: AppBarHomeRealEstate(
              maxHeight: 112 + MediaQuery.of(context).padding.top,
              minHeight: 60 + MediaQuery.of(context).padding.top,
              country: _homePage?.country,
              countrySelected: _countrySelected,
              onPressed: _onSelectCountry,
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
                _buildLocation(),
                _buildPopular(),
                _buildRecommend(),
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
