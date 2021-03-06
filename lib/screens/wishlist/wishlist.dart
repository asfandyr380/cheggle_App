import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class WishList extends StatefulWidget {
  WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() {
    return _WishListState();
  }
}

class _WishListState extends State<WishList> {
  WishListPageModel _listPage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getWishList();
    if (result.success) {
      setState(() {
        _listPage = WishListPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    _loadData();
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///Build list
  Widget _buildList() {
    if (_listPage?.list == null) {
      return ListView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
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

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        itemCount: _listPage.list.isNotEmpty ? _listPage.list.length : 1,
        itemBuilder: (context, index) {
          final item = _listPage.list.isNotEmpty ? _listPage.list[index] : null;
          return _listPage.list.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: AppProductItem(
                    onPressed: _onProductDetail,
                    item: item,
                    type: ProductViewType.small,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "There are no favorites yet add your favorites to wishlist and they will show here",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('wish_list')),
      ),
      body: SafeArea(child: _buildList()),
    );
  }
}
