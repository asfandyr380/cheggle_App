import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/widgets/widget.dart';

class MessageSearch extends StatefulWidget {
  final FocusNode focusNode;
  final Function onClose;
  final Function onPressed;
  MessageSearch({
    Key key,
    this.focusNode,
    this.onClose,
    this.onPressed,
  }) : super(key: key);

  @override
  _MessageSearchState createState() {
    return _MessageSearchState();
  }
}

class _MessageSearchState extends State<MessageSearch> {
  final _textEditingController = TextEditingController();

  Timer _debounce;
  bool _loading = false;
  MessagePageModel _messagePage;

  @override
  void initState() {
    super.initState();
  }

  ///On change search
  void _onChanged(String text) {
    setState(() {
      _loading = true;
    });
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () async {
      final result = await Api.getMessage();
      if (result.success) {
        setState(() {
          _messagePage = MessagePageModel.fromJson(result.data);
          _loading = false;
        });
      }
    });
  }

  ///Build icon
  Widget _buildSuffixIcon() {
    if (_textEditingController.text.isNotEmpty) {
      return IconButton(
        onPressed: () {
          _textEditingController.text = '';
          _onChanged('');
        },
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).iconTheme.color,
        ),
      );
    }
    return null;
  }

  ///Build list
  Widget _buildResult() {
    if (_messagePage?.message != null) {
      return ListView.separated(
        padding: EdgeInsets.only(top: 4),
        itemCount: _messagePage.message.length,
        itemBuilder: (context, index) {
          final item = _messagePage.message[index];
          return AppMessageItem(
            item: item,
            onPressed: () {
              widget.onPressed(item);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    }

    if (_loading) {
      return Container(
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: widget.onClose,
        ),
        title: TextField(
          cursorColor: Colors.white,
          focusNode: widget.focusNode,
          textAlignVertical: TextAlignVertical.center,
          controller: _textEditingController,
          onChanged: _onChanged,
          style: Theme.of(context).primaryTextTheme.button,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16, bottom: 16),
            border: InputBorder.none,
            hintText: 'Enter a search ...',
            hintStyle: Theme.of(context).primaryTextTheme.button,
            suffixIcon: _buildSuffixIcon(),
          ),
        ),
      ),
      body: _buildResult(),
    );
  }
}
