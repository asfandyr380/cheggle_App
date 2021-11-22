import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/message_page_model.dart';
import 'package:listar_flutter/screens/message_search/message_search.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/app_message_item.dart';
import 'package:listar_flutter/widgets/widget.dart';

class MessageList extends StatefulWidget {
  MessageList({Key key}) : super(key: key);

  @override
  _MessageListState createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> {
  final _slideController = SlidableController();
  final _focusNode = FocusNode();

  bool _showSearch = false;
  MessagePageModel _messagePage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getMessage();
    if (result.success) {
      setState(() {
        _messagePage = MessagePageModel.fromJson(result.data);
      });
    }
  }

  ///On search
  void _onSearch() async {
    setState(() {
      _showSearch = true;
    });
    FocusScope.of(context).requestFocus(
      _focusNode,
    );
  }

  ///On close search
  void _onCloseSearch() {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _showSearch = false;
    });
  }

  ///On tap open message
  void _onOpenMessage(MessageModel item) {
    if (_showSearch) {
      _onCloseSearch();
    }
    _onChat(item);
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///On navigate chat screen
  void _onChat(MessageModel item) {
    Navigator.pushNamed(context, Routes.chat, arguments: item.id);
  }

  ///Build list
  Widget _buildList() {
    if (_messagePage?.message == null) {
      return ListView(
        padding: EdgeInsets.only(top: 4),
        children: List.generate(8, (index) => index).map(
          (item) {
            return AppMessageItem();
          },
        ).toList(),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 4),
        itemCount: _messagePage.message.length,
        itemBuilder: (context, index) {
          final item = _messagePage.message[index];
          return Slidable(
            controller: _slideController,
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: AppMessageItem(
              item: item,
              onPressed: () {
                _onChat(item);
              },
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: Translate.of(context).translate('more'),
                color: Theme.of(context).disabledColor,
                icon: Icons.more_horiz,
                onTap: () => {},
              ),
              IconSlideAction(
                caption: Translate.of(context).translate('delete'),
                color: Theme.of(context).accentColor,
                icon: Icons.delete,
                onTap: () => {},
              ),
            ],
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
    return AnimatedIndexedStack(
      index: _showSearch ? 1 : 0,
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.search),
              onPressed: _onSearch,
            ),
            titleSpacing: 0,
            title: InkWell(
              onTap: _onSearch,
              child: Text(
                "Search room ...",
                maxLines: 1,
                style: Theme.of(context).primaryTextTheme.button,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert_outlined),
                onPressed: () {},
              )
            ],
          ),
          body: SafeArea(
            child: _buildList(),
          ),
        ),
        MessageSearch(
          focusNode: _focusNode,
          onClose: _onCloseSearch,
          onPressed: _onOpenMessage,
        ),
      ],
    );
  }
}
