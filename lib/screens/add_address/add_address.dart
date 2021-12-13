import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/other.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/utils/validate.dart';
import 'package:listar_flutter/widgets/app_button.dart';
import 'package:listar_flutter/widgets/app_text_input.dart';

class AddAdress extends StatefulWidget {
  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  String _validFirstName;
  String _validLastName;
  String _validStreet;
  String _validCity;
  String _validPostal;
  String _validEmail;

  final _textFirstNameController = TextEditingController();
  final _textLastNameController = TextEditingController();
  final _textCompanyController = TextEditingController();
  final _textStreetController = TextEditingController();
  final _textStreetController2 = TextEditingController();
  final _textCityController = TextEditingController();
  final _textPostalController = TextEditingController();
  final _textTelephoneController = TextEditingController();
  final _textEmailController = TextEditingController();

  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusCompany = FocusNode();
  final _focusStreet = FocusNode();
  final _focusStreet2 = FocusNode();
  final _focusCity = FocusNode();
  final _focusPostal = FocusNode();
  final _focusTelephone = FocusNode();
  final _focusEmail = FocusNode();

  String selectedPerson;

  final List<String> person_list = ['Mr', "Mrs", 'Various'];

  @override
  void initState() {
    selectedPerson = person_list[0];
    super.initState();
  }

  @override
  void dispose() {
    _textLastNameController.dispose();
    _textFirstNameController.dispose();
    _textEmailController.dispose();
    _textCompanyController.dispose();
    _textPostalController.dispose();
    _textStreetController.dispose();
    _textStreetController2.dispose();
    _textTelephoneController.dispose();
    _textCityController.dispose();
    super.dispose();
  }

  _saveAddress() {
    setState(() {
      _validEmail = UtilValidator.validate(
        data: _textEmailController.text,
        type: Type.email,
      );
      _validStreet = UtilValidator.validate(
        data: _textStreetController.text,
      );
      _validPostal = UtilValidator.validate(
        data: _textPostalController.text,
      );
      _validCity = UtilValidator.validate(
        data: _textCityController.text,
      );
      _validFirstName = UtilValidator.validate(
        data: _textFirstNameController.text,
      );
      _validLastName = UtilValidator.validate(
        data: _textLastNameController.text,
      );
    });

    if (_validEmail == null &&
        _validFirstName == null &&
        _validLastName == null &&
        _validPostal == null &&
        _validCity == null &&
        _validStreet == null) {
      Map data = {
        "person": selectedPerson,
        "firstname": _textFirstNameController.text,
        "lastname": _textLastNameController.text,
        "company": _textCompanyController.text,
        "street": _textStreetController.text,
        "street2": _textStreetController2.text,
        "city": _textCityController.text,
        "postalcode": _textPostalController.text,
        "telephone": _textTelephoneController.text,
        "email": _textEmailController.text,
        'isSelected': false
      };

      Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Add Address'),
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
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('BILLING DETAILS'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Person'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  hint: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('select person'),
                  ),
                  value: selectedPerson,
                  items: person_list.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {
                    setState(() {
                      selectedPerson = _;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('First Name'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input first name'),
                errorText: _validFirstName,
                focusNode: _focusFirstName,
                onTapIcon: () {
                  _textFirstNameController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusFirstName, _focusLastName);
                },
                onChanged: (text) {
                  setState(() {
                    _validFirstName = UtilValidator.validate(
                      data: _textFirstNameController.text,
                    );
                  });
                },
                icon: Icon(Icons.clear),
                controller: _textFirstNameController,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Last Name'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input last name'),
                errorText: _validLastName,
                focusNode: _focusLastName,
                onTapIcon: () {
                  _textLastNameController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusLastName, _focusCompany);
                },
                onChanged: (text) {
                  setState(() {
                    _validLastName = UtilValidator.validate(
                      data: _textLastNameController.text,
                    );
                  });
                },
                icon: Icon(Icons.clear),
                controller: _textLastNameController,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Company (Optional)'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input company name'),
                icon: Icon(Icons.clear),
                controller: _textCompanyController,
                focusNode: _focusCompany,
                textInputAction: TextInputAction.next,
                onChanged: (text) {},
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusCompany, _focusStreet);
                },
                onTapIcon: () {
                  _textCompanyController.clear();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Street'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('street'),
                errorText: _validStreet,
                icon: Icon(Icons.clear),
                controller: _textStreetController,
                focusNode: _focusStreet,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  setState(() {
                    _validStreet = UtilValidator.validate(
                      data: _textStreetController.text,
                    );
                  });
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusStreet, _focusStreet2);
                },
                onTapIcon: () {
                  _textStreetController.clear();
                },
              ),
              SizedBox(
                height: 10,
              ),
              AppTextInput(
                hintText: Translate.of(context)
                    .translate('Apartment, suit (Optional)'),
                icon: Icon(Icons.clear),
                controller: _textStreetController2,
                focusNode: _focusStreet2,
                textInputAction: TextInputAction.next,
                onChanged: (text) {},
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusStreet2, _focusCity);
                },
                onTapIcon: () {
                  _textStreetController2.clear();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('City'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input city name'),
                errorText: _validCity,
                icon: Icon(Icons.clear),
                controller: _textCityController,
                focusNode: _focusCity,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  setState(() {
                    _validCity = UtilValidator.validate(
                      data: _textCityController.text,
                    );
                  });
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(context, _focusCity, _focusPostal);
                },
                onTapIcon: () {
                  _textCityController.clear();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Postal Code'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input postal code'),
                errorText: _validPostal,
                icon: Icon(Icons.clear),
                controller: _textPostalController,
                focusNode: _focusPostal,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  setState(() {
                    _validPostal = UtilValidator.validate(
                      data: _textPostalController.text,
                    );
                  });
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusPostal, _focusTelephone);
                },
                onTapIcon: () {
                  _textPostalController.clear();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('Telephone (Optional)'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input telephone'),
                icon: Icon(Icons.clear),
                controller: _textTelephoneController,
                focusNode: _focusTelephone,
                textInputAction: TextInputAction.next,
                onChanged: (text) {},
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                      context, _focusTelephone, _focusEmail);
                },
                onTapIcon: () {
                  _textTelephoneController.clear();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                child: Text(
                  Translate.of(context).translate('email'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              AppTextInput(
                hintText: Translate.of(context).translate('input email'),
                errorText: _validEmail,
                focusNode: _focusEmail,
                onTapIcon: () {
                  _textEmailController.clear();
                },
                onSubmitted: (text) {
                  _saveAddress();
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
              SizedBox(height: 20),
              AppButton(
                Translate.of(context).translate('Save'),
                onPressed: () => _saveAddress(),
                loading: false,
                disabled: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
