import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/category_page_model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<Category> {
  final _textController = TextEditingController();

  CategoryType _type = CategoryType.full;
  CategoryPageModel _categoryPage;
  List<CategoryModel> _category;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///On clear search
  Future<void> _onClearTapped() async {
    _textController.text = '';
    _onSearch('');
  }

  ///On change mode view
  void _onChangeModeView() {
    switch (_type) {
      case CategoryType.full:
        setState(() {
          _type = CategoryType.icon;
        });
        break;
      case CategoryType.icon:
        setState(() {
          _type = CategoryType.full;
        });
        break;
      default:
        break;
    }
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getCategory();
    if (result.success) {
      setState(() {
        _categoryPage = CategoryPageModel.fromJson(result.data);
        _category = _categoryPage.category;
      });
    }
  }

  ///On refresh list
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///On navigate list product
  void _onProductList(CategoryModel item) {
    Navigator.pushNamed(
      context,
      Routes.listProduct,
      arguments: item.title,
    );
  }

  ///On Search Category
  void _onSearch(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _category = _category.where(((item) {
          return item.title.toUpperCase().contains(text.toUpperCase());
        })).toList();
      });
    } else {
      setState(() {
        _category = _categoryPage.category;
      });
    }
  }

  ///Build UI list
  Widget _buildList() {
    if (_category == null) {
      return ListView.builder(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        itemCount: List.generate(8, (index) => index).length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppCategory(type: _type),
          );
        },
      );
    }

    if (_category.isEmpty) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_satisfied),
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                Translate.of(context).translate('category_not_found'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        itemCount: _category.length,
        itemBuilder: (context, index) {
          final item = _category[index];
          return AppCategory(
            type: _type,
            item: item,
            onPressed: (item) {
              _onProductList(item);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('category')),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _type == CategoryType.icon
                  ? Icons.view_headline
                  : Icons.view_agenda,
            ),
            onPressed: _onChangeModeView,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: AppTextInput(
                hintText: Translate.of(context).translate('search'),
                onTapIcon: _onClearTapped,
                icon: Icon(Icons.clear),
                controller: _textController,
                onSubmitted: _onSearch,
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: _buildList(),
            )
          ],
        ),
      ),
    );
  }
}
