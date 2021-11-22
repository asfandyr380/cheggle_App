import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';

abstract class ThemeEvent {}

class OnChangeTheme extends ThemeEvent {
  final ThemeModel theme;
  final String font;
  final DarkOption darkOption;

  OnChangeTheme({
    this.theme,
    this.font,
    this.darkOption,
  });
}

class ChangeDarkOption extends ThemeEvent {
  final DarkOption darkOption;

  ChangeDarkOption({this.darkOption});
}
