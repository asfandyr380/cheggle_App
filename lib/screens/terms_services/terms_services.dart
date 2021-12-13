// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/data.dart';
import 'package:listar_flutter/utils/translate.dart';

class TermsServices extends StatefulWidget {
  @override
  _TermsServicesState createState() => _TermsServicesState();
}

class _TermsServicesState extends State<TermsServices> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Map terms;
  Future<void> _loadData() async {
    final result = await UtilData.termsServices();
    setState(() {
      terms = result['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Terms & Conditions'),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.center,
        child: terms != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text('SCOPE AND PROVIDER',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                    ),
                    Text(terms['SCOPE AND PROVIDER'][0]['title'],
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 10),
                    Text(terms['SCOPE AND PROVIDER'][1]['title'],
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 10),
                    Text(terms['SCOPE AND PROVIDER'][2]['title'],
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 10),
                    Text(terms['SCOPE AND PROVIDER'][3]['title'],
                        style: Theme.of(context).textTheme.bodyText2),
                    // Bullets
                    SizedBox(height: 10),
                    for (var bullet in terms['SCOPE AND PROVIDER'][3]
                        ['bullets'])
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(bullet,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10),

                    Text(terms['SCOPE AND PROVIDER'][4]['title'],
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 10),

                    for (var bullet in terms['SCOPE AND PROVIDER'][4]
                        ['bullets'])
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(bullet,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                      ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text('CONCLUSION OF THE CONTRACT',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                    ),

                    for (var c in terms['CONCLUSION OF THE CONTRACT'])
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(c,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text('DESCRIPTION OF THE SCOPE OF SERVICES',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                    ),

                    for (var d in terms['DESCRIPTION OF THE SCOPE OF SERVICES'])
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(d,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text('PRICES, SHIPPING COSTS, CONDITIONS',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                    ),

                    for (var p in terms['PRICES, SHIPPING COSTS, CONDITIONS'])
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(p,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text(
                          'DELIVERY / PROVISION OF SERVICES AND CANCELLATION',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                    ),

                    for (var d in terms[
                        'DELIVERY / PROVISION OF SERVICES AND CANCELLATION'])
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(d,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                  ],
                ),
              )
            : null,
      )),
    );
  }
}
