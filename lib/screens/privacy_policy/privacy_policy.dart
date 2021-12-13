import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/data.dart';
import 'package:listar_flutter/utils/translate.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Map privacy;
  Future<void> _loadData() async {
    final result = await UtilData.privacyPolicy();
    setState(() {
      privacy = result['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Privacy Policy'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.center,
          child: privacy != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Text('DATA PROTECTION AT A GLANCE',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                      ),
                      Text('GENERAL INFORMATION',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['DATA PROTECTION AT A GLANCE']
                              ['GENERAL INFORMATION'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('DATA COLLECTION ON THIS WEBSITE',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          'Who is responsible for data collection on this website?',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10),
                      Text(
                          privacy['DATA PROTECTION AT A GLANCE']
                                  ['DATA COLLECTION ON THIS WEBSITE'][0][
                              'Who is responsible for data collection on this website?'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('How do we collect your data?',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10),
                      Text(
                          privacy['DATA PROTECTION AT A GLANCE']
                                  ['DATA COLLECTION ON THIS WEBSITE'][1]
                              ['How do we collect your data?'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('What do we use your data for?',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10),
                      Text(
                          privacy['DATA PROTECTION AT A GLANCE']
                                  ['DATA COLLECTION ON THIS WEBSITE'][2]
                              ['What do we use your data for?'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('What rights do you have with regard to your data?',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10),
                      Text(
                          privacy['DATA PROTECTION AT A GLANCE']
                                  ['DATA COLLECTION ON THIS WEBSITE'][3][
                              'What rights do you have with regard to your data?'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('ANALYSIS TOOLS AND THIRD PARTY TOOLS',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['DATA PROTECTION AT A GLANCE']
                              ['ANALYSIS TOOLS AND THIRD PARTY TOOLS'],
                          style: Theme.of(context).textTheme.bodyText2),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Text(
                            'HOSTING AND CONTENT DELIVERY NETWORKS (CDN)',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                      ),
                      Text('EXTERNAL HOSTING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['HOSTING AND CONTENT DELIVERY NETWORKS (CDN)']
                              ['EXTERNAL HOSTING'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('Conclusion of an order processing contract',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['HOSTING AND CONTENT DELIVERY NETWORKS (CDN)']
                              ['Conclusion of an order processing contract'],
                          style: Theme.of(context).textTheme.bodyText2),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Text(
                            'GENERAL INFORMATION AND MANDATORY INFORMATION',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                      ),
                      Text('PRIVACY',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['PRIVACY'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('NOTE ON THE RESPONSIBLE BODY',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][0],
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][1],
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][2],
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][3],
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][4],
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][5],
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON THE RESPONSIBLE BODY'][6],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('NOTE ON DATA TRANSFER TO THE USA',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['NOTE ON DATA TRANSFER TO THE USA'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text('REVOCATION OF YOUR CONSENT TO DATA PROCESSING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              ['REVOCATION OF YOUR CONSENT TO DATA PROCESSING'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text(
                          'RIGHT TO OBJECT TO THE COLLECTION OF DATA IN SPECIAL CASES AND TO DIRECT MAIL (ART. 21 GDPR)',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              [
                              'RIGHT TO OBJECT TO THE COLLECTION OF DATA IN SPECIAL CASES AND TO DIRECT MAIL (ART. 21 GDPR)'],
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text(
                          'RIGHT OF APPEAL TO THE COMPETENT SUPERVISORY AUTHORITY',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 17)),
                      SizedBox(height: 10),
                      Text(
                          privacy['GENERAL INFORMATION AND MANDATORY INFORMATION']
                              [
                              'RIGHT OF APPEAL TO THE COMPETENT SUPERVISORY AUTHORITY'],
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
