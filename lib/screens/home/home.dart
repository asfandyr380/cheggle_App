import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/screens/home/home_category_item.dart';
import 'package:listar_flutter/screens/home/home_category_list.dart';
import 'package:listar_flutter/screens/home/home_sliver_app_bar.dart';
import 'package:listar_flutter/screens/profile/profile.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/app_recommended_card.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  ///AppStore review
  // final date = DateTime(2021, 5, 5);
  // bool showDemo = false;

  HomePageModel _homePage;
  BusinessState _business = AppBloc.businessCubit.state;

  @override
  void initState() {
    super.initState();
    _loadData();

    ///AppStore review
    // final now = DateTime.now();
    // if (now.isAfter(date)) {
    //   showDemo = true;
    // }
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getHome();
    if (result.success) {
      setState(() {
        _homePage = HomePageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    _loadData();
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

  ///On select category
  void _onTapService(CategoryModel item) {
    Navigator.pushNamed(context, Routes.listProduct, arguments: item.title);
  }

  ///On Open More
  void _onOpenMore() async {
    final item = await showModalBottomSheet<CategoryModel>(
      context: context,
      builder: (BuildContext context) {
        return HomeCategoryList(
          category: _homePage?.category,
          onOpenList: () {
            Navigator.pushNamed(context, Routes.category);
          },
          onPress: (item) {
            Navigator.pop(context, item);
          },
        );
      },
    );
    if (item != null) {
      await Future.delayed(Duration(milliseconds: 300));
      _onTapService(item);
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    // Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    showDialog(context: context, builder: (_) => _buildDialog(item));
  }

  ///Is Selected Business
  Color _exportColor(BusinessState business) {
    if (business == _business) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).dividerColor;
  }

  ///Build category UI
  Widget _buildCategory() {
    if (_homePage?.category == null) {
      return Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: List.generate(8, (index) => index).map(
          (item) {
            return HomeCategoryItem();
          },
        ).toList(),
      );
    }

    List<Widget> listBuild = _homePage.category.map(
      (item) {
        return HomeCategoryItem(
          item: item,
          onPressed: _onTapService,
        );
      },
    ).toList();

    ///Take 7 Item
    if (listBuild.length > 7) {
      listBuild = _homePage.category.take(7).map(
        (item) {
          return HomeCategoryItem(
            item: item,
            onPressed: _onTapService,
          );
        },
      ).toList();
    }

    ///More Category
    listBuild.add(HomeCategoryItem(
      item: CategoryModel.fromJson({
        "id": "9",
        "title": Translate.of(context).translate("more"),
        "icon": "more_horiz",
        "color": "#ff8a65",
        "type": "more"
      }),
      onPressed: (item) {
        _onOpenMore();
      },
    ));

    return Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: listBuild,
    );
  }

  ///Build popular UI
  Widget _buildPopular() {
    if (_homePage?.popular == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: AppProductItem(
              type: ProductViewType.cardLarge,
            ),
          );
        },
        itemCount: List.generate(8, (index) => index).length,
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final item = _homePage.popular[index];
        return Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: AppProductItem(
            item: item,
            type: ProductViewType.cardLarge,
            onPressed: _onProductDetail,
          ),
        );
      },
      itemCount: _homePage.popular.length,
    );
  }

  //Build list Hot
  Widget _buildHot() {
    if (_homePage?.popular == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: AppProductItem(type: ProductViewType.gird),
          );
        },
        itemCount: List.generate(8, (index) => index).length,
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 16),
      itemBuilder: (context, index) {
        final ProductModel item = _homePage.hot[index];
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
      itemCount: _homePage.hot.length,
    );
  }

  //Build list Recommended
  Widget _buildRecommended() {
    if (_homePage?.popular == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: RecommendationCard(),
          );
        },
        itemCount: List.generate(8, (index) => index).length,
      );
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 16),
      itemBuilder: (context, index) {
        final CategoryModel item = _homePage.recommended[index];
        Color textColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
        return Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.only(right: 16),
          child: RecommendationCard(
            onPressed: () => _onTapService(item),
            item: item,
            textColor: textColor,
          ),
        );
      },
      itemCount: _homePage.recommended.length,
    );
  }

  ///Build list recent
  Widget _buildList() {
    if (_homePage?.list == null) {
      return Column(
        children: List.generate(8, (index) => index).map(
          (item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AppProductItem(type: ProductViewType.small),
            );
          },
        ).toList(),
      );
    }

    return Column(
      children: _homePage.list.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppProductItem(
            onPressed: _onProductDetail,
            item: item,
            type: ProductViewType.small,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDialog(ProductModel item) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      title: Text(
        item.title,
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(item.image),
            SizedBox(height: 30),
            _buildContactInfo(icon: Icons.location_on, text: item.address),
            SizedBox(height: 20),
            _buildContactInfo(icon: Icons.phone, text: item.phone),
            SizedBox(height: 20),
            _buildContactInfo(icon: Icons.mail, text: item.email),
            SizedBox(height: 20),
            Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            RatingBar.builder(
              onRatingUpdate: (_) {},
              initialRating: item.rate.toDouble(),
              minRating: 1,
              allowHalfRating: true,
              unratedColor: Colors.black.withAlpha(100),
              itemCount: 5,
              itemSize: 20.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.black,
              ),
              ignoreGestures: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Profile(preview: true, id: item.autherId)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Text('Go to Profile'),
        ),
      ],
    );
  }

  _buildContactInfo({IconData icon, String text}) => Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(
            width: 5,
          ),
          Expanded(child: Text(text))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeSliver(
              expandedHeight: 250,
              banners: _homePage?.banner,
            ),
            pinned: true,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: _buildCategory(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate(
                                  'popular_location',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              Text(
                                Translate.of(context).translate(
                                  'let_find_interesting',
                                ),
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 190,
                      child: _buildPopular(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate(
                              'Recommendations',
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      child: _buildRecommended(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate(
                                  'What\'s Hot',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              Text(
                                Translate.of(context).translate(
                                  'Lets see what\'s trending',
                                ),
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 220,
                      child: _buildHot(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate(
                                  'recent_location',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                              ),
                              Text(
                                Translate.of(context).translate('what_happen'),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: _buildList(),
                    ),
                  ],
                )
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
