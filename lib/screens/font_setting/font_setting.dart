import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class FontSetting extends StatefulWidget {
  FontSetting({Key key}) : super(key: key);

  @override
  _FontSettingState createState() {
    return _FontSettingState();
  }
}

class _FontSettingState extends State<FontSetting> {
  String _currentFont = AppTheme.currentFont;

  @override
  void initState() {
    super.initState();
  }

  ///On change Font
  void _onChange() async {
    AppBloc.themeBloc.add(OnChangeTheme(font: _currentFont));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('font'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                itemBuilder: (context, index) {
                  Widget trailing = Container();
                  final item = AppTheme.fontSupport[index];
                  if (item == _currentFont) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return AppListTitle(
                    title: item,
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        _currentFont = item;
                      });
                    },
                    textStyle: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontFamily: item),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: AppTheme.fontSupport.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('apply'),
                onPressed: _onChange,
              ),
            )
          ],
        ),
      ),
    );
  }
}
