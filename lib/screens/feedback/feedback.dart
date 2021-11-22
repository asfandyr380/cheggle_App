import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class WriteReview extends StatefulWidget {
  final UserModel author;

  WriteReview({
    Key key,
    this.author,
  }) : super(key: key);

  @override
  _WriteReviewState createState() {
    return _WriteReviewState();
  }
}

class _WriteReviewState extends State<WriteReview> {
  final _textTitle = TextEditingController();
  final _textReview = TextEditingController();

  final _focusTitle = FocusNode();
  final _focusReview = FocusNode();

  String _validTitle;
  String _validReview;
  double _rate = 4;

  @override
  void initState() {
    super.initState();
  }

  ///On send
  Future<void> _send() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validTitle = UtilValidator.validate(
        data: _textTitle.text,
      );
      _validReview = UtilValidator.validate(
        data: _textReview.text,
      );
    });
    if (_validTitle == null && _validReview == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('feedback'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              Translate.of(context).translate('send'),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
            onPressed: _send,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(widget.author.image),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: RatingBar.builder(
                  initialRating: _rate,
                  minRating: 1,
                  allowHalfRating: true,
                  unratedColor: Colors.amber.withAlpha(100),
                  itemCount: 5,
                  itemSize: 24.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      _rate = value;
                    });
                  },
                ),
              ),
              Text(
                Translate.of(context).translate('tap_rate'),
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        Translate.of(context).translate('title'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    AppTextInput(
                      hintText: Translate.of(context).translate(
                        'input_title',
                      ),
                      errorText: _validTitle,
                      focusNode: _focusTitle,
                      textInputAction: TextInputAction.next,
                      onTapIcon: () {
                        _textTitle.clear();
                      },
                      onSubmitted: (text) {
                        UtilOther.fieldFocusChange(
                          context,
                          _focusTitle,
                          _focusReview,
                        );
                      },
                      onChanged: (text) {
                        setState(() {
                          _validTitle = UtilValidator.validate(
                            data: _textTitle.text,
                          );
                        });
                      },
                      icon: Icon(Icons.clear),
                      controller: _textTitle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        Translate.of(context).translate('description'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    AppTextInput(
                      hintText: Translate.of(context).translate(
                        'input_feedback',
                      ),
                      errorText: _validReview,
                      focusNode: _focusReview,
                      maxLines: 5,
                      onTapIcon: () {
                        _textReview.clear();
                      },
                      onSubmitted: (text) {
                        _send();
                      },
                      onChanged: (text) {
                        setState(() {
                          _validReview = UtilValidator.validate(
                            data: _textReview.text,
                          );
                        });
                      },
                      icon: Icon(Icons.clear),
                      controller: _textReview,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
