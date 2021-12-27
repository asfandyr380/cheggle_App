import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model_result_api.dart';
import 'package:listar_flutter/models/screen_models/profile_page_model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  final _picker = ImagePicker();
  final _textNameController = TextEditingController();
  final _textLastNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textWebsiteController = TextEditingController();

  final _focusName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusAddress = FocusNode();
  final _focusWebsite = FocusNode();

  XFile _image;
  bool _loading = false;
  String _validName;
  String _validLastName;
  String _validEmail;
  String _validAddress;
  String _validWebsite;

  ProfilePageModel _profilePage;

  @override
  void initState() {
    super.initState();
    _loadData().then((value) {
      _textNameController.text = _profilePage.user.firstName;
      _textLastNameController.text = _profilePage.user.lastName;
      _textEmailController.text = _profilePage.user.email;
      _textAddressController.text = _profilePage.user.address;
      _textWebsiteController.text = _profilePage.user.website;
    });
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getProfile(null);
    if (result.success) {
      setState(() {
        _profilePage = ProfilePageModel.fromJson(result.data);
      });
    }
  }

  ///On async get Image file
  Future _getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final ResultApiModel result = await Api.uploadProfileImg(
        id: _profilePage.user.id,
        filePath: image.path,
      );
      if (result.success) {
        setState(() {
          _image = image;
        });
      }
    }
  }

  ///On update image
  Future<void> _update() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validName = UtilValidator.validate(
        data: _textNameController.text,
      );
      _validLastName = UtilValidator.validate(
        data: _textLastNameController.text,
      );
      _validEmail = UtilValidator.validate(
        data: _textEmailController.text,
        type: Type.email,
      );
      _validAddress = UtilValidator.validate(
        data: _textAddressController.text,
      );
      _validWebsite = UtilValidator.validate(
        data: _textWebsiteController.text,
      );
    });
    if (_validName == null &&
        _validLastName == null &&
        _validEmail == null &&
        _validAddress == null &&
        _validWebsite == null) {
      setState(() {
        _loading = true;
      });
      final ResultApiModel result = await Api.updateProfile(
        id: _profilePage.user.id,
        firstName: _textNameController.text,
        lastName: _textLastNameController.text,
        email: _textEmailController.text,
        address: _textAddressController.text,
        website: _textWebsiteController.text,
      );
      if (result.success) {
        Navigator.pop(context);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('edit_profile')),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            child: _image == null
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: _profilePage != null
                                            ? NetworkImage(
                                                '$BASE_URL_Img${_profilePage.user.image}')
                                            : AssetImage(Images.Avatar1),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(_image.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: _getImage,
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      Translate.of(context).translate('First Name'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppTextInput(
                    hintText: Translate.of(context).translate('input_name'),
                    errorText: _validName,
                    focusNode: _focusName,
                    textInputAction: TextInputAction.next,
                    onTapIcon: () {
                      _textNameController.clear();
                    },
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusName,
                        _focusLastName,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _validName = UtilValidator.validate(
                          data: _textNameController.text,
                        );
                      });
                    },
                    icon: Icon(Icons.clear),
                    controller: _textNameController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      Translate.of(context).translate('Last Name'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppTextInput(
                    hintText: Translate.of(context).translate('input_name'),
                    errorText: _validLastName,
                    focusNode: _focusLastName,
                    textInputAction: TextInputAction.next,
                    onTapIcon: () {
                      _textLastNameController.clear();
                    },
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusLastName,
                        _focusEmail,
                      );
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
                    padding: EdgeInsets.only(top: 16, bottom: 8),
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
                    focusNode: _focusEmail,
                    textInputAction: TextInputAction.next,
                    onTapIcon: () {
                      _textEmailController.clear();
                    },
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusEmail,
                        _focusAddress,
                      );
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
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      Translate.of(context).translate('address'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppTextInput(
                    hintText: Translate.of(context).translate('input_address'),
                    errorText: _validAddress,
                    focusNode: _focusAddress,
                    textInputAction: TextInputAction.next,
                    onTapIcon: () {
                      _textAddressController.clear();
                    },
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusAddress,
                        _focusWebsite,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _validAddress = UtilValidator.validate(
                          data: _textAddressController.text,
                        );
                      });
                    },
                    icon: Icon(Icons.clear),
                    controller: _textAddressController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      Translate.of(context).translate('website'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppTextInput(
                    hintText: Translate.of(context).translate('input_website'),
                    errorText: _validAddress,
                    focusNode: _focusWebsite,
                    textInputAction: TextInputAction.next,
                    onTapIcon: () {
                      _textWebsiteController.clear();
                    },
                    onSubmitted: (text) {
                      _update();
                    },
                    onChanged: (text) {
                      setState(() {
                        _validAddress = UtilValidator.validate(
                          data: _textWebsiteController.text,
                        );
                      });
                    },
                    icon: Icon(Icons.clear),
                    controller: _textWebsiteController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('confirm'),
                onPressed: _update,
                loading: _loading,
                disabled: _loading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
