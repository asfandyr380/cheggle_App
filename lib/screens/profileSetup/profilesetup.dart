// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/screens/about_us/about_us.dart';
import 'package:listar_flutter/utils/other.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/widgets/app_button.dart';
import 'package:listar_flutter/widgets/app_text_input.dart';

class ProfileSetup extends StatefulWidget {
  final String id;
  ProfileSetup({@required this.id});
  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  List<String> services = [];
  List partners = [];
  List selectedPartners = [];
  final _serviceController = TextEditingController();
  final _aboutUsController = TextEditingController();
  String _valueService;
  String _valueAboutUs;
  final http = HTTPManager();

  loadPartners() async {
    var result = await http.get(
      url: '$BASE_URL/partners',
    );
    if (result['success']) {
      setState(() {
        partners = result['data'];
      });
    }
  }

  @override
  void initState() {
    loadPartners();
    super.initState();
  }

  @override
  void dispose() {
    _serviceController.dispose();
    _aboutUsController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  _submit() async {
    setState(() {
      isLoading = true;
    });
    if (services.isEmpty || services == null) {
      setState(() {
        _valueService = "Please Add Your Services";
      });
    } else if (_aboutUsController.text.isEmpty) {
      setState(() {
        _valueAboutUs = "About Us Cant be Empty";
      });
    } else {
      var result = await http.post(
        url: '$BASE_URL/user/update/setup/${widget.id}',
        data: {'services': services, 'aboutUs': _aboutUsController.text, 'partners': selectedPartners}
      );
      if (result['success']) {
        Navigator.pop(context);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  selectPartner(String partner) {
    if (selectedPartners == null || selectedPartners.isEmpty) {
      setState(() {
        selectedPartners.add(partner);
      });
    } else {
      if (selectedPartners.contains(partner)) {
        setState(() {
          selectedPartners.remove(partner);
        });
      } else {
        setState(() {
          selectedPartners.add(partner);
        });
      }
    }
    print(selectedPartners);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Setup'),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Services'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context)
                      .translate('Add services you provide'),
                  errorText: _valueService,
                  onTapIcon: () {
                    _serviceController.clear();
                  },
                  onSubmitted: (text) {
                    setState(() {
                      _valueService = null;
                      services.add(text);
                    });
                    _serviceController.clear();
                  },
                  onChanged: (text) {},
                  icon: Icon(Icons.clear),
                  controller: _serviceController,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var service in services)
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor),
                          child: Row(
                            children: [
                              Text(
                                service,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    services.remove(service);
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('About Us'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText:
                      Translate.of(context).translate('Tell us about yourself'),
                  errorText: _valueAboutUs,
                  maxLines: 7,
                  onTapIcon: () {
                    _aboutUsController.clear();
                  },
                  onSubmitted: (text) {
                    UtilOther.hiddenKeyboard(context);
                  },
                  onChanged: (text) {
                    setState(() {
                      _valueAboutUs = null;
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _aboutUsController,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Select Partners'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20),
                partners != null
                    ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          for (var partner in partners)
                            InkWell(
                              onTap: () => selectPartner(partner['name']),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedPartners
                                            .contains(partner['name'])
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey),
                                child: Text(
                                  partner['name'].toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 40),
                AppButton(
                  Translate.of(context).translate('Submit'),
                  onPressed: () => _submit(),
                  loading: isLoading,
                  disabled: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
