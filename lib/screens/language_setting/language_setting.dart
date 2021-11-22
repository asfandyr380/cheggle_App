import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/language.dart';
import 'package:listar_flutter/utils/other.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class LanguageSetting extends StatefulWidget {
  LanguageSetting({Key key}) : super(key: key);

  @override
  _LanguageSettingState createState() {
    return _LanguageSettingState();
  }
}

class _LanguageSettingState extends State<LanguageSetting> {
  final _textLanguageController = TextEditingController();

  List<Locale> _listLanguage = AppLanguage.supportLanguage;
  Locale _languageSelected = AppLanguage.defaultLanguage;

  @override
  void initState() {
    super.initState();
  }

  ///On filter language
  void _onFilter(String text) {
    if (text.isEmpty) {
      setState(() {
        _listLanguage = AppLanguage.supportLanguage;
      });
      return;
    }
    setState(() {
      _listLanguage = _listLanguage.where(((item) {
        return UtilLanguage.getGlobalLanguageName(item.languageCode)
            .toUpperCase()
            .contains(text.toUpperCase());
      })).toList();
    });
  }

  ///On change language
  Future<void> _changeLanguage() async {
    UtilOther.hiddenKeyboard(context);
    AppBloc.languageBloc.add(
      OnChangeLanguage(_languageSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('change_language')),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: AppTextInput(
                hintText: Translate.of(context).translate('search'),
                icon: Icon(Icons.clear),
                controller: _textLanguageController,
                onChanged: _onFilter,
                onSubmitted: _onFilter,
                onTapIcon: () {
                  _textLanguageController.clear();
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(left: 16, right: 16),
                itemBuilder: (context, index) {
                  final item = _listLanguage[index];
                  Widget trailing = Container();
                  if (item == _languageSelected) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return AppListTitle(
                    title: UtilLanguage.getGlobalLanguageName(
                      item.languageCode,
                    ),
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        _languageSelected = item;
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: _listLanguage.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('confirm'),
                onPressed: _changeLanguage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
