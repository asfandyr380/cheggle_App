// ignore_for_file: sdk_version_ui_as_code

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/blocs/app_bloc.dart';
import 'package:listar_flutter/blocs/login/login_event.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/app_button.dart';
import 'package:listar_flutter/widgets/app_text_input.dart';

class CashBox extends StatefulWidget {
  CashBox({@required this.data});
  final Map data;
  @override
  _CashBoxState createState() => _CashBoxState();
}

class _CashBoxState extends State<CashBox> {
  String _validCoupon;

  final _couponController = TextEditingController();

  final _couponFocus = FocusNode();

  String selectedPerson;

  final List<String> person_list = ['Mr', "Mrs", 'Various'];
  List<Map> addresslist = [];

  Map package;
  Map addtional_service;
  double subtotal = 0;
  double vat_percent = 1.19;
  double vat_amount = 0;
  double package_additinal_price;
  double total = 0;
  @override
  void initState() {
    selectedPerson = person_list[0];
    setState(() {
      package = widget.data['Package'];
      addtional_service = widget.data['Additional_Service'];
      double package_price = double.tryParse(package['price']);
      package_additinal_price = double.tryParse(package['additional_price']);
      subtotal += package_price;

      if (addtional_service != null) {
        double additional_Price = double.tryParse(addtional_service['price']);
        subtotal += additional_Price;
      }
      if (package_additinal_price != null) {
        subtotal += package_additinal_price;
      }

      total += subtotal;
      vat_amount = (vat_percent * subtotal);
      total += vat_amount;
    });
    super.initState();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  bool _hide = true;
  _hideField() {
    setState(() {
      if (_hide)
        _hide = false;
      else
        _hide = true;
    });
  }

  bool transfer = false;
  bool instant_banking = false;

  Map selectedAddress;
  bool _isLoading = false;
  _buyNow() async {
    setState(() {
      _isLoading = true;
    });
    Map fromData = widget.data['form_data'];
    final http = HTTPManager();
    var result = await http.post(
      url: '$BASE_URL/auth/signup',
      data: fromData,
    );
    if (result['success']) {
      AppBloc.loginBloc.add(OnLogin(
        username: fromData['email'],
        password: fromData['password'],
      ));
      if (widget.data['Package']['id'] == 1) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, Routes.profileSetup,
            arguments: result['id']);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('CashBox'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Translate.of(context).translate('Do you have a voucher?'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () => _hideField(), child: Text('Click here.'))
                ],
              ),
              // Coupon Text Field

              Visibility(
                visible: !_hide,
                child: AppTextInput(
                  hintText:
                      Translate.of(context).translate('input Coupon code'),
                  errorText: _validCoupon,
                  icon: Icon(Icons.clear),
                  controller: _couponController,
                  focusNode: _couponFocus,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validCoupon = UtilValidator.validate(
                        data: _couponController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.hiddenKeyboard(context);
                  },
                  onTapIcon: () {
                    _couponController.clear();
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.addAddress)
                        .then((address) {
                      if (address != null) {
                        setState(() {
                          addresslist.add(address);
                        });
                      }
                    });
                  },
                  child: addresslist.isEmpty
                      ? Text('Add Address')
                      : Column(
                          children: [
                            for (var address in addresslist)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: address['isSelected'],
                                        onChanged: (state) {
                                          setState(() {
                                            selectedAddress = address;
                                            addresslist.forEach((e) {
                                              if (e['street'] ==
                                                  address['street']) {
                                                e['isSelected'] = state;
                                              } else {
                                                e['isSelected'] = false;
                                              }
                                            });
                                          });
                                        }),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${address['person']} ${address['firstname']} ${address['lastname']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 15),
                                        ),
                                        Text(
                                          "${address['street']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 15),
                                        ),
                                        Text(
                                          "${address['city']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 15),
                                        ),
                                        Text(
                                          "${address['postalcode']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.add)
                                  ],
                                ),
                              ),
                          ],
                        ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Choose payment Method'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),

              Row(
                children: [
                  Checkbox(
                      value: transfer,
                      onChanged: (state) {
                        setState(() {
                          transfer = state;
                          instant_banking = false;
                        });
                      }),
                  Text('Transfer'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: instant_banking,
                      onChanged: (state) {
                        setState(() {
                          instant_banking = state;
                          transfer = false;
                        });
                      }),
                  Text('Instant Banking'),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Text(
                  Translate.of(context).translate('Your Order'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff3d3c3f),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context).translate('Products'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          Text(
                            Translate.of(context).translate('Subtotal'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                    // Products
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context)
                                .translate('${package['title']} * 1'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          Text(
                            Translate.of(context).translate(
                                '€ ${package['price']} ${package['recursive'] ? '/ month' : ''}'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    package_additinal_price != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Translate.of(context)
                                      .translate('Additinal Charges'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                ),
                                Text(
                                  Translate.of(context)
                                      .translate('€ $package_additinal_price'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    Divider(thickness: 4),
                    SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context).translate('Subtotal'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            Translate.of(context).translate('€ $subtotal'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context).translate('19% Vat'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            Translate.of(context).translate(
                                '€ ${vat_amount.toStringAsFixed(2)}'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context).translate('Total'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            Translate.of(context).translate('€ $total'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    package['recursive']
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Translate.of(context)
                                      .translate('Recurring total'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                ),
                                Text(
                                  Translate.of(context)
                                      .translate('€ ${package['price']}'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 20),

              AppButton(
                Translate.of(context).translate('Buy Now'),
                onPressed: () => _buyNow(),
                loading: _isLoading,
                disabled: (selectedAddress != null && transfer) ? false : true,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
