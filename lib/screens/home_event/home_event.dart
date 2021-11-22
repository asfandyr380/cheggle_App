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

import 'appbar_home_event.dart';

class HomeEvent extends StatefulWidget {
  HomeEvent({Key key}) : super(key: key);

  @override
  _HomeEventState createState() {
    return _HomeEventState();
  }
}

class _HomeEventState extends State<HomeEvent> {
  HomeEventPageModel _homePage;
  BusinessState _business = AppBloc.businessCubit.state;

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
        _homePage = HomeEventPageModel.fromJson(result.data);
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
  void _onProductDetail(ProductEventModel item) {
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

  ///Is Selected Business
  Color _exportColor(BusinessState business) {
    if (business == _business) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).dividerColor;
  }

  ///Build list category
  Widget _buildCategory() {
    Widget content = ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AppPlaceholder(
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
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
      itemCount: 8,
    );
    if (_homePage?.categorys != null) {
      content = ListView.separated(
        padding: EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage.categorys[index];
          return Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: InkWell(
              onTap: () {
                _onProductList(item);
              },
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.3),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Icon(
                      item.icon,
                      size: 32,
                      color: item.color,
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
          return SizedBox(width: 8);
        },
        itemCount: _homePage.categorys.length,
      );

      ///Empty
      if (_homePage.categorys.isEmpty) {
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
      height: 88,
      child: content,
    );
  }

  ///Build Feature List
  Widget _buildFeature() {
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

    if (_homePage?.features != null) {
      content = ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage.features[index];
          return Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            width: 200,
            child: AppProductEventItem(
              item: item,
              onPressed: _onProductDetail,
              type: ProductViewType.gird,
            ),
          );
        },
        itemCount: _homePage.features.length,
      );

      ///Empty
      if (_homePage.features.isEmpty) {
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
                Translate.of(context).translate('feature_event'),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                Translate.of(context).translate('let_find_around'),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        Container(
          height: 244,
          child: content,
        )
      ],
    );
  }

  ///Build news
  Widget _buildNews() {
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

    if (_homePage?.news != null) {
      content = ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          final item = _homePage.news[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppProductEventItem(
              item: item,
              onPressed: _onProductDetail,
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: _homePage.news.length,
      );

      ///Empty
      if (_homePage.news.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('date_not_found'),
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
                Translate.of(context).translate('new_event'),
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
            delegate: AppBarHomeEvent(
              maxHeight: 124 + MediaQuery.of(context).padding.top,
              minHeight: 64 + MediaQuery.of(context).padding.top,
              today: DateTime.now(),
              onPressed: _onNotification,
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
                _buildCategory(),
                _buildFeature(),
                _buildNews(),
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
