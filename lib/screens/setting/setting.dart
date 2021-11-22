import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/language.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  bool _receiveNotification = true;
  DarkOption _darkOption = AppTheme.darkThemeOption;

  @override
  void initState() {
    super.initState();
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///Show notification received
  Future<void> _showDarkModeSetting() async {
    setState(() {
      _darkOption = AppTheme.darkThemeOption;
    });
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('dark_mode')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.dynamic),
                        ),
                      ),
                      value: _darkOption == DarkOption.dynamic,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.dynamic;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOn),
                        ),
                      ),
                      value: _darkOption == DarkOption.alwaysOn,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.alwaysOn;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOff),
                        ),
                      ),
                      value: _darkOption == DarkOption.alwaysOff,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.alwaysOff;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('close'),
              onPressed: () {
                Navigator.pop(context, false);
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('apply'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    if (result == true) {
      AppBloc.themeBloc.add(OnChangeTheme(darkOption: _darkOption));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('setting'),
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          children: <Widget>[
            AppListTitle(
              title: Translate.of(context).translate('language'),
              onPressed: () {
                _onNavigate(Routes.changeLanguage);
              },
              trailing: Row(
                children: <Widget>[
                  Text(
                    UtilLanguage.getGlobalLanguageName(
                      AppLanguage.defaultLanguage.languageCode,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            AppListTitle(
              title: Translate.of(context).translate('notification'),
              trailing: Switch(
                value: _receiveNotification,
                onChanged: (value) {
                  setState(() {
                    _receiveNotification = value;
                  });
                },
              ),
            ),
            Divider(),
            AppListTitle(
              title: Translate.of(context).translate('theme'),
              onPressed: () {
                _onNavigate(Routes.themeSetting);
              },
              trailing: Container(
                margin: EdgeInsets.only(right: 8),
                width: 16,
                height: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Divider(),
            AppListTitle(
              title: Translate.of(context).translate('dark_mode'),
              onPressed: _showDarkModeSetting,
              trailing: Row(
                children: <Widget>[
                  Text(
                    Translate.of(context).translate(
                      UtilTheme.exportLangTheme(AppTheme.darkThemeOption),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            AppListTitle(
              title: Translate.of(context).translate('font'),
              onPressed: () {
                _onNavigate(Routes.fontSetting);
              },
              trailing: Row(
                children: <Widget>[
                  Text(
                    AppTheme.currentFont,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            AppListTitle(
              title: Translate.of(context).translate('version'),
              onPressed: () {},
              trailing: Row(
                children: <Widget>[
                  Text(
                    Application.version,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
