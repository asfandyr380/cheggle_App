// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/configs/routes.dart';
import 'package:listar_flutter/utils/other.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/utils/validate.dart';
import 'package:listar_flutter/widgets/app_button.dart';
import 'package:listar_flutter/widgets/app_text_input.dart';
import 'package:map_place_picker/map_place_picker.dart';

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
  List<String> media_list = ["Facebook", "Instagram", "Twitter", "LinkdIn"];
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> times = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "24:00",
  ];
  List<String> tier_list = ["Basic", "Exclusive", "Platinium"];

  List<Map> media_links = [];
  List<Map> savedDays = [];
  List<Map> savedPriceList = [];
  List<Map> savedMenuList = [];

  List<String> tierServices = [];

  final _serviceController = TextEditingController();
  final _aboutUsController = TextEditingController();
  final _mediaController = TextEditingController();
  final _packageNameController = TextEditingController();
  final _tierServiceController = TextEditingController();
  final _tierPriceController = TextEditingController();
  final _menuServiceContrller = TextEditingController();
  final _menuPriceContrller = TextEditingController();

  String _valueService;
  String _valueAboutUs;
  String _valueHours;
  String _valuePackegeName;
  String _valuetierService;
  String _valuetierPrice;
  String _valueMenuService;
  String _valueMenuPrice;
  String _valueLocation;

  String selectedMedia;
  String selectedDay;
  String selectedTime1;
  String selectedTime2;
  String selectedTier;
  MapAddress selectedLocation;

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
    selectedTime1 = times[0];
    selectedTime2 = times[2];
    selectedTier = tier_list[0];
    super.initState();
  }

  @override
  void dispose() {
    _serviceController.dispose();
    _aboutUsController.dispose();
    _mediaController.dispose();

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
    } else if (savedDays.isEmpty || savedDays == null) {
      _valueHours = "Please Add Working Hours";
    } else if (selectedLocation == null) {
      _valueLocation = "Please Select Location";
    } else {
      String f;
      String i;
      String t;
      String l;
      media_links.forEach((e) {
        switch (e.values.first) {
          case "Facebook":
            f = e.values.last;
            break;
          case "Instagram":
            i = e.values.last;
            break;
          case "Twitter":
            t = e.values.last;
            break;
          case "LinkdIn":
            l = e.values.last;
            break;
        }
      });
      var result = await http
          .post(url: '$BASE_URL/user/update/setup/${widget.id}', data: {
        'services': services,
        'aboutUs': _aboutUsController.text,
        'partners': selectedPartners,
        'facebook': f ?? "",
        'instagram': i ?? "",
        'twitter': t ?? "",
        'linkdin': l ?? "",
        'hour_details': savedDays,
        'location': {
          "name": selectedLocation.address,
          "lat": selectedLocation.latitude,
          "long": selectedLocation.longitude,
        },
        'pricing_list': savedPriceList,
        'menu_list': savedMenuList,
      });
      if (result['success']) {
        Navigator.pop(context);
      }
    }
    setState(() {
      isLoading = false;
    });
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
                // Services Field
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
                    setState(() {
                      _valueService = null;
                      services.add(_serviceController.text);
                    });
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
                  icon: Icon(Icons.add),
                  controller: _serviceController,
                ),
                // Services Tags
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
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // About Us Field
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
                // Partners Selection Grid
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

                // Social Media Links
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Social Media'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                for (var link in media_links)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        link['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(link['url']),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              media_links.remove(link);
                            });
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('please select'),
                          ),
                          value: selectedMedia,
                          items: media_list.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectedMedia = _;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 7,
                      child: AppTextInput(
                        hintText: Translate.of(context)
                            .translate('enter website url'),
                        onTapIcon: () {
                          _mediaController.clear();
                        },
                        onChanged: (text) {},
                        icon: Icon(Icons.clear),
                        controller: _mediaController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                AppButton(
                  "Add",
                  onPressed: () {
                    if (selectedMedia != null &&
                        _mediaController.text.isNotEmpty &&
                        _mediaController.text != null) {
                      var media = {
                        "title": selectedMedia,
                        "url": _mediaController.text
                      };
                      setState(() {
                        media_links.add(media);
                      });
                      selectedMedia = null;
                      _mediaController.clear();
                    }
                  },
                  disabled: false,
                  loading: false,
                ),

                // Open Time
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Open Time'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                _valueHours != null
                    ? Text(
                        _valueHours,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                for (var day in savedDays)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(day['time']),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              savedDays.remove(day);
                            });
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('day'),
                          ),
                          value: selectedDay,
                          items: days.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectedDay = _;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('please select'),
                          ),
                          value: selectedTime1,
                          items: times.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectedTime1 = _;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('please select'),
                          ),
                          value: selectedTime2,
                          items: times.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectedTime2 = _;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                AppButton(
                  Translate.of(context).translate('Add'),
                  onPressed: () {
                    if (selectedDay != null) {
                      var day = {
                        "title": selectedDay,
                        'time': "$selectedTime1 to $selectedTime2"
                      };
                      setState(() {
                        savedDays.add(day);
                        selectedDay = null;
                        _valueHours = null;
                      });
                    }
                  },
                  loading: isLoading,
                  disabled: isLoading,
                ),

                // Price List
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Price List'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                for (var price in savedPriceList)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(price['name']),
                      SizedBox(width: 10),
                      Text("€${price['price']}"),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              savedPriceList.remove(price);
                            });
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('please select'),
                          ),
                          value: selectedTier,
                          items: tier_list.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectedTier = _;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 7,
                      child: AppTextInput(
                        hintText:
                            Translate.of(context).translate('package name'),
                        onTapIcon: () {
                          _packageNameController.clear();
                        },
                        errorText: _valuePackegeName,
                        onChanged: (text) {
                          setState(() {
                            _valuePackegeName = null;
                          });
                        },
                        icon: Icon(Icons.clear),
                        controller: _packageNameController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var service in tierServices)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            service,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                AppTextInput(
                  hintText: Translate.of(context).translate('Add Services'),
                  onTapIcon: () {
                    setState(() {
                      tierServices.add(_tierServiceController.text);
                    });
                    _tierServiceController.clear();
                  },
                  onChanged: (text) {
                    setState(() {
                      _valuetierService = null;
                    });
                  },
                  errorText: _valuetierService,
                  icon: Icon(Icons.add),
                  controller: _tierServiceController,
                ),
                SizedBox(height: 10),
                AppTextInput(
                  hintText: Translate.of(context).translate('€ price'),
                  onTapIcon: () {
                    _tierPriceController.clear();
                  },
                  onChanged: (text) {
                    setState(() {
                      _valuetierPrice = null;
                    });
                  },
                  errorText: _valuetierPrice,
                  icon: Icon(Icons.close),
                  controller: _tierPriceController,
                ),
                SizedBox(height: 10),
                AppButton(
                  Translate.of(context).translate('Create Package'),
                  onPressed: () {
                    setState(() {
                      _valuePackegeName = UtilValidator.validate(
                          data: _packageNameController.text);
                      _valuetierPrice = UtilValidator.validate(
                          data: _tierPriceController.text);
                      _valuetierService = tierServices.isEmpty
                          ? "add at least one service"
                          : null;
                    });

                    if (selectedTier != null &&
                        _valuePackegeName == null &&
                        _valuetierPrice == null &&
                        _valuetierService == null) {
                      var package = {
                        "title": selectedTier,
                        "name": _packageNameController.text,
                        "services": tierServices,
                        "price": _tierPriceController.text,
                      };
                      print(package);
                      setState(() {
                        savedPriceList.add(package);
                      });
                      _packageNameController.clear();
                      _tierPriceController.clear();
                      tierServices = [];
                    }
                    print(savedPriceList);
                  },
                  loading: false,
                  disabled: false,
                ),

                // Menu Listing
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Menu'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                for (var menu in savedMenuList)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        menu['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text("€${menu['price']}"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            savedMenuList.remove(menu);
                          });
                        },
                        icon: Icon(Icons.close),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: AppTextInput(
                        hintText:
                            Translate.of(context).translate('enter service'),
                        onTapIcon: () {
                          _menuServiceContrller.clear();
                        },
                        onChanged: (text) {
                          setState(() {
                            _valueMenuService = null;
                          });
                        },
                        errorText: _valueMenuService,
                        icon: Icon(Icons.clear),
                        controller: _menuServiceContrller,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: AppTextInput(
                        hintText: Translate.of(context).translate('€ price'),
                        onTapIcon: () {
                          _menuPriceContrller.clear();
                        },
                        onChanged: (text) {
                          setState(() {
                            _valueMenuPrice = null;
                          });
                        },
                        icon: Icon(Icons.clear),
                        errorText: _valueMenuPrice,
                        controller: _menuPriceContrller,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                AppButton(
                  Translate.of(context).translate('Add'),
                  onPressed: () {
                    setState(
                      () {
                        _valueMenuPrice = UtilValidator.validate(
                            data: _menuPriceContrller.text);
                        _valueMenuService = UtilValidator.validate(
                            data: _menuServiceContrller.text);
                      },
                    );

                    if (_valueMenuService == null && _valueMenuPrice == null) {
                      var menu = {
                        'title': _menuServiceContrller.text,
                        'price': _menuPriceContrller.text
                      };
                      setState(() {
                        savedMenuList.add(menu);
                      });
                      _menuServiceContrller.clear();
                      _menuPriceContrller.clear();
                    }
                  },
                  loading: false,
                  disabled: false,
                ),

                // Location Picker
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    Translate.of(context).translate('Pick Location'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                _valueLocation != null
                    ? Text(
                        _valueLocation,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                selectedLocation != null
                    ? Text(selectedLocation.address)
                    : Container(),
                AppButton(
                  Translate.of(context).translate('Enter Location'),
                  onPressed: () {
                    setState(() {
                      _valueLocation = null;
                    });
                    MapPicker.show(
                        context, "AIzaSyAGHlk0PoZ-BdSwUJh_HGSHXWKlARE4Pt8",
                        (p0) {
                      setState(() {
                        selectedLocation = p0;
                      });
                      print(p0.address);
                    });
                  },
                  icon: Icon(Icons.location_on),
                  loading: false,
                  disabled: false,
                ),

                // Submit Button
                SizedBox(height: 40),
                AppButton(
                  Translate.of(context).translate('Submit'),
                  onPressed: () => _submit(),
                  loading: isLoading,
                  disabled: isLoading,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
