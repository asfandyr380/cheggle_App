import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class WishListFood extends StatefulWidget {
  WishListFood({Key key}) : super(key: key);

  @override
  _WishListFoodState createState() {
    return _WishListFoodState();
  }
}

class _WishListFoodState extends State<WishListFood> {
  WishListFoodPageModel _listPage;

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
        _listPage = WishListFoodPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///On navigate product detail
  void _onProductDetail(ProductFoodModel item) {
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
              child: AppProductEventItem(type: ProductViewType.small),
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
        itemCount: _listPage.list.length,
        itemBuilder: (context, index) {
          final item = _listPage.list[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppProductFoodItem(
              onPressed: _onProductDetail,
              item: item,
              type: ProductViewType.small,
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
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }
}
