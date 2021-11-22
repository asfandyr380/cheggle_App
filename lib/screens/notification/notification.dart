import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key key}) : super(key: key);

  @override
  _NotificationListState createState() {
    return _NotificationListState();
  }
}

class _NotificationListState extends State<NotificationList> {
  NotificationPageModel _notificationPage;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final result = await Api.getNotification();
    if (result.success) {
      setState(() {
        _notificationPage = NotificationPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///Build list
  Widget _buildList() {
    if (_notificationPage?.notification == null) {
      return ListView(
        padding: EdgeInsets.only(top: 4),
        children: List.generate(8, (index) => index).map(
          (item) {
            return AppNotificationItem();
          },
        ).toList(),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 4),
        itemCount: _notificationPage.notification.length,
        itemBuilder: (context, index) {
          final item = _notificationPage.notification[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            child: AppNotificationItem(
              item: item,
              onPressed: () {},
            ),
            background: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16, right: 16),
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onDismissed: (direction) {
              _notificationPage.notification.removeAt(index);
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
        title: Text(
          Translate.of(context).translate('notification'),
        ),
      ),
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }
}
