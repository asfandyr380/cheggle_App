import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/chat_page_model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/screens/chat/chat_input/chat_input.dart';
import 'package:listar_flutter/screens/chat/chat_item.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Chat extends StatefulWidget {
  final int id;

  Chat({this.id});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool _loading = true;
  ChatPageModel _chatPage;
  List<MessageModel> _message;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getDetailMessage(id: widget.id);
    if (result.success) {
      setState(() {
        _chatPage = ChatPageModel.fromJson(result.data);
        _message = _chatPage.message;
        _loading = false;
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  ///On Send message
  void _onSend(String text) {
    if (text.isNotEmpty) {
      final chat = MessageModel.fromJson({
        "id": 6,
        "message": text,
        "date": DateFormat.jm().format(DateTime.now()),
        "status": "sent"
      });
      setState(() {
        _message.add(chat);
      });
      UtilOther.hiddenKeyboard(context);
    }
  }

  ///Build info Room
  Widget _buildInfo() {
    if (_chatPage?.member == null) {
      return null;
    }

    return Row(
      children: <Widget>[
        AppGroupCircleAvatar(
          member: _chatPage.member,
          size: 48,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _chatPage.roomName,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              _chatPage.online > 0
                  ? Text(
                      '${_chatPage.online > 1 ? _chatPage.online : ''} Online',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Theme.of(context).accentColor),
                    )
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  ///Build Content
  Widget _buildContent() {
    final media = MediaQuery.of(context);
    final keyboardHeight = media.viewInsets.bottom + media.padding.bottom;

    if (_loading) {
      return Center(
        child: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SafeArea(
              top: false,
              bottom: false,
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  final item = _message[index];
                  return ChatItem(item: item);
                },
              ),
            ),
          ),
        ),
        ChatInput(
          onSend: _onSend,
          keyboardHeight: keyboardHeight,
          minimum: media.padding.bottom,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: _buildInfo(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: _buildContent(),
      ),
    );
  }
}
