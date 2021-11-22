import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ThemeSetting extends StatefulWidget {
  ThemeSetting({Key key}) : super(key: key);

  @override
  _ThemeSettingState createState() {
    return _ThemeSettingState();
  }
}

class _ThemeSettingState extends State<ThemeSetting> {
  ThemeModel _currentTheme = AppTheme.currentTheme;

  @override
  void initState() {
    super.initState();
  }

  ///On Change Theme
  void _onChange() {
    AppBloc.themeBloc.add(OnChangeTheme(theme: _currentTheme));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('theme'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                itemBuilder: (context, index) {
                  final item = AppTheme.themeSupport[index];
                  final selected = item.name == _currentTheme.name;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentTheme = item;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                color: item.color,
                              ),
                              SizedBox(width: 8),
                              Text(
                                Translate.of(context).translate(item.name),
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                          selected
                              ? Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: AppTheme.themeSupport.length,
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
