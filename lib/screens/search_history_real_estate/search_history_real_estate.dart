import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

import 'search_result_real_estate_list.dart';
import 'search_suggest_real_estate_list.dart';

class SearchHistoryRealEstate extends StatefulWidget {
  SearchHistoryRealEstate({Key key}) : super(key: key);

  @override
  _SearchHistoryRealEstateState createState() {
    return _SearchHistoryRealEstateState();
  }
}

class _SearchHistoryRealEstateState extends State<SearchHistoryRealEstate> {
  SearchHistoryRealEstatePageModel _historyPage;
  RealEstateSearchDelegate _delegate = RealEstateSearchDelegate();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    setState(() {
      _historyPage = null;
    });
    final ResultApiModel result = await Api.getHistorySearch();
    if (result.success) {
      setState(() {
        _historyPage = SearchHistoryRealEstatePageModel.fromJson(result.data);
      });
    }
  }

  Future<ProductRealEstateModel> _onSearch() async {
    final selected = await showSearch(
      context: context,
      delegate: _delegate,
    );
    return selected;
  }

  ///On navigate list product
  void _onProductList(CategoryModel item) {
    Navigator.pushNamed(
      context,
      Routes.listProduct,
      arguments: item.title,
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductRealEstateModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///Build list tag
  List<Widget> _listTag(BuildContext context) {
    if (_historyPage?.history == null) {
      return List.generate(6, (index) => index).map(
        (item) {
          return AppPlaceholder(
            child: AppTag(
              Translate.of(context).translate('loading'),
            ),
          );
        },
      ).toList();
    }

    return _historyPage.history.map((item) {
      return InputChip(
        onPressed: () {
          _onProductDetail(item);
        },
        label: Text(item.title),
        onDeleted: () {
          _historyPage.history.remove(item);
          setState(() {});
        },
      );
    }).toList();
  }

  ///Build list discover
  List<Widget> _listDiscover(BuildContext context) {
    if (_historyPage?.discover == null) {
      return List.generate(6, (index) => index).map(
        (item) {
          return AppPlaceholder(
            child: AppTag(
              Translate.of(context).translate('loading'),
            ),
          );
        },
      ).toList();
    }

    return _historyPage.discover.map((item) {
      return InputChip(
        onPressed: () {
          _onProductList(item);
        },
        label: Text(item.title),
        onDeleted: () {
          _historyPage.discover.remove(item);
          setState(() {});
        },
      );
    }).toList();
  }

  ///Build popular
  List<Widget> _listRecently() {
    if (_historyPage?.recently == null) {
      return List.generate(8, (index) => index).map(
        (item) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: AppProductItem(
              type: ProductViewType.cardSmall,
            ),
          );
        },
      ).toList();
    }

    return _historyPage.recently.map(
      (item) {
        return Padding(
          padding: EdgeInsets.only(right: 16),
          child: AppProductRealEstateItem(
            onPressed: _onProductDetail,
            item: item,
            type: ProductViewType.cardSmall,
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _delegate?.transitionAnimation,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(Translate.of(context).translate('search_title')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearch,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Translate.of(context)
                            .translate('search_history')
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          _historyPage.history.clear();
                          setState(() {});
                        },
                        child: Text(
                          Translate.of(context).translate('clear'),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Theme.of(context).accentColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    children: _listTag(context),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Translate.of(context)
                            .translate('discover_more')
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          _historyPage.discover.clear();
                          setState(() {});
                        },
                        child: Text(
                          Translate.of(context).translate('clear'),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Theme.of(context).accentColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    children: _listDiscover(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    Translate.of(context)
                        .translate('recently_viewed')
                        .toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                padding: EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 4,
                ),
                scrollDirection: Axis.horizontal,
                children: _listRecently(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RealEstateSearchDelegate extends SearchDelegate<ProductRealEstateModel> {
  RealEstateSearchDelegate();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionRealEstateList(query: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultRealEstateList(query: query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      ];
    }
    return null;
  }
}
