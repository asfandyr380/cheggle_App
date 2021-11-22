import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  final _textPassController = TextEditingController();
  final _textRePassController = TextEditingController();
  final _focusPass = FocusNode();
  final _focusRePass = FocusNode();

  bool _loading = false;
  String _validPass;
  String _validRePass;

  ///On change password
  Future<void> _changePassword() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validPass = UtilValidator.validate(
        data: _textPassController.text,
      );
      _validRePass = UtilValidator.validate(
        data: _textRePassController.text,
      );
    });
    if (_validPass == null && _validRePass == null) {
      setState(() {
        _loading = true;
      });
      await Future.delayed(Duration(seconds: 1));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('change_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    Translate.of(context).translate('password'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_your_password',
                  ),
                  errorText: _validPass,
                  focusNode: _focusPass,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onTapIcon: () {
                    _textPassController.clear();
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusPass,
                      _focusRePass,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _validPass = UtilValidator.validate(
                        data: _textPassController.text,
                      );
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textPassController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    Translate.of(context).translate('confirm_password'),
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'confirm_your_password',
                  ),
                  errorText: _validRePass,
                  focusNode: _focusRePass,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  onTapIcon: () {
                    _textRePassController.clear();
                  },
                  onSubmitted: (text) {
                    _changePassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _validRePass = UtilValidator.validate(
                          data: _textRePassController.text);
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textRePassController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: AppButton(
                    Translate.of(context).translate('confirm'),
                    onPressed: _changePassword,
                    loading: _loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
