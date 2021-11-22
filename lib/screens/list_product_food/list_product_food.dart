import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/repository/list.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ListProductFood extends StatefulWidget {
  final String title;

  ListProductFood({Key key, this.title}) : super(key: key);

  @override
  _ListProductFoodState createState() {
    return _ListProductFoodState();
  }
}

class _ListProductFoodState extends State<ListProductFood> {
  final listRepository = ListRepository();
  final _swipeController = SwiperController();

  GoogleMapController _mapController;
  int _indexLocation = 0;
  MapType _mapType = MapType.normal;
  CameraPosition _initPosition;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  PageType _pageType = PageType.list;
  ProductViewType _modeView = ProductViewType.gird;
  ProductListFoodPageModel _productPage;
  SortModel _currentSort;
  List<SortModel> _listSort;

  @override
  void initState() {
    super.initState();
    _loadData();
    _currentSort = listRepository.listSortDefault[0];
    _listSort = listRepository.listSortDefault;
  }

  ///On Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getProduct();
    if (result.success) {
      final productPage = ProductListFoodPageModel.fromJson(result.data);

      ///Setup list marker map from list
      productPage.list.forEach((item) {
        final markerId = MarkerId(item.id.toString());
        final marker = Marker(
          markerId: markerId,
          position: LatLng(item.location.lat, item.location.long),
          infoWindow: InfoWindow(title: item.title),
          onTap: () {
            _onSelectLocation(item);
          },
        );
        _markers[markerId] = marker;
      });

      setState(() {
        _productPage = productPage;
        _initPosition = CameraPosition(
          target: LatLng(
            productPage.list[0].location.lat,
            productPage.list[0].location.long,
          ),
          zoom: 14.4746,
        );
      });
    }
  }

  ///On Refresh List
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///On Change Sort
  void _onChangeSort() async {
    final result = await showModalBottomSheet<SortModel>(
      context: context,
      builder: (BuildContext context) {
        return AppBottomSheet(
          selected: _currentSort,
          option: _listSort,
          onPressed: (item) {
            Navigator.pop(context, item);
          },
        );
      },
    );
    if (result != null) {
      setState(() {
        _currentSort = result;
      });
    }
  }

  ///On Change View
  void _onChangeView(PageType pageType) {
    if (pageType == PageType.map) {
      switch (_mapType) {
        case MapType.normal:
          _mapType = MapType.hybrid;
          break;
        case MapType.hybrid:
          _mapType = MapType.normal;
          break;
        default:
          _mapType = MapType.normal;
          break;
      }
    } else {
      switch (_modeView) {
        case ProductViewType.gird:
          _modeView = ProductViewType.list;
          break;
        case ProductViewType.list:
          _modeView = ProductViewType.block;
          break;
        case ProductViewType.block:
          _modeView = ProductViewType.gird;
          break;
        default:
          return;
      }
    }

    setState(() {
      _modeView = _modeView;
      _mapType = _mapType;
    });
  }

  ///On change filter
  void _onChangeFilter() {
    Navigator.pushNamed(context, Routes.filter);
  }

  ///On change page
  void _onChangePageStyle() {
    switch (_pageType) {
      case PageType.list:
        setState(() {
          _pageType = PageType.map;
        });
        return;
      case PageType.map:
        setState(() {
          _pageType = PageType.list;
        });
        return;
    }
  }

  ///On tap marker map location
  void _onSelectLocation(ProductFoodModel item) {
    final index = _productPage.list.indexOf(item);
    _swipeController.move(index);
  }

  ///Handle Index change list map view
  void _onIndexChange(int index) {
    setState(() {
      _indexLocation = index;
    });

    ///Camera animated
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(
            _productPage.list[_indexLocation].location.lat,
            _productPage.list[_indexLocation].location.long,
          ),
          tilt: 30.0,
          zoom: 15.0,
        ),
      ),
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductFoodModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///Export Icon for Mode View
  IconData _exportIconView() {
    if (_pageType == PageType.map) {
      switch (_mapType) {
        case MapType.normal:
          return Icons.map;
        case MapType.hybrid:
          return Icons.satellite;
        default:
          return Icons.map;
      }
    }

    switch (_modeView) {
      case ProductViewType.list:
        return Icons.view_list;
      case ProductViewType.gird:
        return Icons.view_quilt;
      case ProductViewType.block:
        return Icons.view_array;
      default:
        return Icons.help;
    }
  }

  ///_build Item Loading
  Widget _buildItemLoading(ProductViewType type) {
    switch (type) {
      case ProductViewType.gird:
        return AppProductItem(
          type: _modeView,
        );

      case ProductViewType.list:
        return Container(
          padding: EdgeInsets.only(left: 16),
          child: AppProductItem(
            type: _modeView,
          ),
        );

      default:
        return AppProductItem(
          type: _modeView,
        );
    }
  }

  ///_build Item
  Widget _buildItem(ProductFoodModel item, ProductViewType type) {
    switch (type) {
      case ProductViewType.gird:
        return AppProductFoodItem(
          onPressed: _onProductDetail,
          item: item,
          type: _modeView,
        );

      case ProductViewType.list:
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: AppProductFoodItem(
            onPressed: _onProductDetail,
            item: item,
            type: _modeView,
          ),
        );

      default:
        return AppProductFoodItem(
          onPressed: _onProductDetail,
          item: item,
          type: _modeView,
        );
    }
  }

  ///Widget build Content
  Widget _buildList() {
    if (_productPage?.list == null) {
      ///Build Loading

      if (_modeView == ProductViewType.gird) {
        final deviceWidth = MediaQuery.of(context).size.width;
        final itemHeight = 205;
        final safeLeft = MediaQuery.of(context).padding.left;
        final safeRight = MediaQuery.of(context).padding.right;
        final itemWidth = (deviceWidth - 16 * 3 - safeLeft - safeRight) / 2;
        final ratio = itemWidth / itemHeight;
        return GridView.count(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: ratio,
          children: List.generate(8, (index) => index).map((item) {
            return _buildItemLoading(_modeView);
          }).toList(),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: _buildItemLoading(_modeView),
          );
        },
        itemCount: 8,
      );
    }

    ///Build list
    if (_modeView == ProductViewType.gird) {
      final deviceWidth = MediaQuery.of(context).size.width;
      final itemHeight = 205;
      final safeLeft = MediaQuery.of(context).padding.left;
      final safeRight = MediaQuery.of(context).padding.right;
      final itemWidth = (deviceWidth - 16 * 3 - safeLeft - safeRight) / 2;
      final ratio = itemWidth / itemHeight;
      return GridView.count(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        childAspectRatio: ratio,
        children: _productPage.list.map((item) {
          return _buildItem(item, _modeView);
        }).toList(),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        final item = _productPage.list[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: _buildItem(item, _modeView),
        );
      },
      itemCount: _productPage.list.length,
    );
  }

  ///Build Content Page Style
  Widget _buildContent() {
    if (_pageType == PageType.list) {
      return SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: _buildList(),
        ),
      );
    }

    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            mapType: _mapType,
            initialCameraPosition: _initPosition,
            markers: Set<Marker>.of(_markers.values),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
          ),
          SafeArea(
            bottom: false,
            top: false,
            child: Container(
              height: 200,
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).dividerColor,
                                blurRadius: 5,
                                spreadRadius: 1.0,
                                offset: Offset(1.5, 1.5),
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).dividerColor,
                                  blurRadius: 5,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.5, 1.5),
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Swiper(
                      itemBuilder: (context, index) {
                        final item = _productPage.list[index];
                        return Container(
                          padding: EdgeInsets.only(top: 4, bottom: 4),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _indexLocation == index
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).dividerColor,
                                  blurRadius: 5,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.5, 1.5),
                                )
                              ],
                            ),
                            child: AppProductFoodItem(
                              onPressed: _onProductDetail,
                              item: item,
                              type: ProductViewType.list,
                            ),
                          ),
                        );
                      },
                      controller: _swipeController,
                      onIndexChanged: (index) {
                        _onIndexChange(index);
                      },
                      itemCount: _productPage.list.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearch,
          ),
          Visibility(
            visible: _productPage?.list != null,
            child: IconButton(
              icon: Icon(
                _pageType == PageType.map ? Icons.view_compact : Icons.map,
              ),
              onPressed: _onChangePageStyle,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          AppNavBar(
            pageStyle: _pageType,
            currentSort: _currentSort,
            onChangeSort: _onChangeSort,
            iconModeView: _exportIconView(),
            onChangeView: _onChangeView,
            onFilter: _onChangeFilter,
          ),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }
}
