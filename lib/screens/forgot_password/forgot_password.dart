import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _textEmailController = TextEditingController();

  bool _loading = false;
  String _validEmail;

  @override
  void initState() {
    super.initState();
  }

  ///Fetch API
  Future<void> _forgotPassword() async {
    setState(() {
      _validEmail = UtilValidator.validate(
        data: _textEmailController.text,
        type: Type.email,
      );
    });
    if (_validEmail == null) {
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
          Translate.of(context).translate('forgot_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    Translate.of(context).translate('email'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_email'),
                  errorText: _validEmail,
                  onTapIcon: () {
                    _textEmailController.clear();
                  },
                  onSubmitted: (text) {
                    _forgotPassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _validEmail = UtilValidator.validate(
                        data: _textEmailController.text,
                        type: Type.email,
                      );
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('reset_password'),
                  onPressed: _forgotPassword,
                  loading: _loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
