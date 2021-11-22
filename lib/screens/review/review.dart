import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Review extends StatefulWidget {
  Review({Key key}) : super(key: key);

  @override
  _ReviewState createState() {
    return _ReviewState();
  }
}

class _ReviewState extends State<Review> {
  ReviewPageModel _reviewPage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getReview();
    if (result.success) {
      setState(() {
        _reviewPage = ReviewPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///On navigate write review
  void _onWriteReview() {
    Navigator.pushNamed(
      context,
      Routes.writeReview,
      arguments: _reviewPage.author,
    );
  }

  ///Build list
  Widget _buildList() {
    if (_reviewPage?.comment == null) {
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
              child: AppCommentItem(),
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
        itemCount: _reviewPage.comment.length,
        itemBuilder: (context, index) {
          final item = _reviewPage.comment[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppCommentItem(item: item),
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
        title: Text(
          Translate.of(context).translate('review'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              Translate.of(context).translate('write'),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
            onPressed: _onWriteReview,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: AppRating(
                rate: _reviewPage?.rate,
              ),
            ),
            Expanded(child: _buildList())
          ],
        ),
      ),
    );
  }
}
