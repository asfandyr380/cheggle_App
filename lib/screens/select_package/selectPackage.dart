// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/routes.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/widgets/app_button.dart';

class SelectPackage extends StatefulWidget {
  Map data;
  SelectPackage({@required this.data});
  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  List<Map> cards = [
    {
      'id': 1,
      'title': "CHEGGl VIDEO",
      "subtitle": "Your individual marketing video",
      "price": "79.00",
      'price_first': "from only",
      'price_last': '/ plus 19% VAT.',
      'button_text': 'Book a Cheggle Video',
      'recursive': false,
      "additional_price": "",
      'feature_list': [
        {'title': "Professional video production", 'spacial': false},
        {'title': "Cut and Effects", 'spacial': false},
        {'title': "Setting to music", 'spacial': false},
        {'title': "HD quality", 'spacial': false},
        {'title': "no follow-up costs", 'spacial': true},
        {'title': "Ideal for social media", 'spacial': false},
        {'title': "Integration into your website", 'spacial': false},
        {'title': "Presentation at events", 'spacial': false},
      ],
    },
    {
      'id': 2,
      'title': "PREMIUM PACKAGE",
      "subtitle": "including all top functions",
      "price": "5.00",
      'price_first': "now only",
      'price_last': '/ month.',
      'button_text': 'Join Now',
      'recursive': true,
      "additional_price": "",
      'feature_list': [
        {'title': "multimedia company profile", 'spacial': false},
        {'title': "can be canceled monthly", 'spacial': false},
        {'title': "no follow-up costs", 'spacial': false},
        {'title': "including ALL premium tools", 'spacial': false},
        {'title': "booking request", 'spacial': false},
        {'title': "video gallery", 'spacial': false},
        {'title': "route planner", 'spacial': false},
        {'title': "contact box", 'spacial': false},
        {'title': "Document upload, etc", 'spacial': false},
      ],
    },
    {
      'id': 3,
      'title': "VIDEO + PREMIUM",
      "subtitle": "Your combo package to get you started",
      "price": "5.00",
      'price_first': "month /",
      'price_last': '+ € 199.00 one-time',
      'button_text': 'Book a Combination Package',
      'recursive': true,
      "additional_price": "199.00",
      'feature_list': [
        {'title': "Professional video production", 'spacial': false},
        {'title': "complete post production", 'spacial': false},
        {'title': "Hosting & Streaming", 'spacial': false},
        {'title': "HD quality", 'spacial': false},
        {'title': "Upload to your Cheggl profile", 'spacial': false},
        {'title': "Multimedia profile page", 'spacial': false},
        {'title': "all premium functions", 'spacial': true},
        {'title': "extensive usage rights", 'spacial': false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Select Package'),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var card in cards)
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: PackageCard(
                    data: card,
                    onPress: () {
                      if (card['id'] == 2 || card['id'] == 3) {
                        widget.data['roles'] = ['moderator'];
                      }
                      Map data = {'form_data': widget.data, 'card': card};
                      Navigator.pushReplacementNamed(
                          context, Routes.uploadContent,
                          arguments: data);
                    },
                  ),
                )
            ],
          ),
        ),
      )),
    );
  }
}

class PackageCard extends StatelessWidget {
  const PackageCard({@required this.data, @required this.onPress});
  final Map data;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff3d3c3f), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                Translate.of(context).translate(data['title']),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                data['subtitle'],
                style:
                    Theme.of(context).textTheme.bodyText1.copyWith(height: 1.3),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${data['price_first']} ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(height: 1.3, fontSize: 14),
                ),
                Text(
                  "€ ${data['price']} ",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      height: 1.3,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
                Text(
                  "${data['price_last']}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(height: 1.3, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 20),
            for (var f in data['feature_list'])
              Text(
                f['title'],
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    height: 1.3,
                    fontWeight: f['spacial'] ? FontWeight.w700 : null),
              ),
            SizedBox(height: 10),
            AppButton(
              Translate.of(context).translate(data['button_text']),
              onPressed: () => onPress(),
              loading: false,
              disabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
