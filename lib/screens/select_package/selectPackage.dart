// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/api/http_manager.dart';
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
  List cards = [];
  bool isLoading = false;

  setBusy(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    setBusy(true);
    var http = HTTPManager();
    var result = await http.get(url: "$BASE_URL/packages");
    if (result['success']) {
      setState(() {
        cards = result['data'];
      });
    }
    setBusy(false);
  }

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
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: PackageCard(
                          data: card,
                          onPress: () {
                            if (card['premium']) {
                              widget.data['roles'] = ['moderator'];
                            }
                            Map data = {'form_data': widget.data, 'card': card};
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.uploadContent,
                              arguments: data,
                            );
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
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
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
            Center(
              child: Text(
                "€ ${data['price'].toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    height: 1.3,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
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
