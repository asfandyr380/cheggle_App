import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/filter_page_model.dart';
import 'package:listar_flutter/utils/language.dart';
import 'package:listar_flutter/utils/utils.dart';

enum TimeType { start, end }

class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() {
    return _FilterState();
  }
}

class _FilterState extends State<Filter> {
  final FilterPageModel _filterPage = FilterPageModel.fromJson({
    "category": [
      "Architecture",
      "Insurance",
      "Beauty",
      "Artists",
      "Outdoors",
      "Clothing",
      "Jewelry",
      "Medical"
    ],
    "service": [
      "Free Wifi",
      "Shower",
      "Pet Allowed",
      "Shuttle Bus",
      "Supper Market",
      "Open 24/7",
    ]
  });

  final List<Color> _color = [
    Color.fromRGBO(93, 173, 226, 1),
    Color.fromRGBO(165, 105, 189, 1),
    Color(0xffe5634d),
    Color.fromRGBO(88, 214, 141, 1),
    Color.fromRGBO(253, 198, 10, 1),
    Color(0xffa0877e),
    Color.fromRGBO(93, 109, 126, 1)
  ];
  List<LocationModel> _locationSelected = [];
  List<LocationModel> _areaSelected = [];
  TimeOfDay _startHour = TimeOfDay(hour: 12, minute: 15);
  TimeOfDay _endHour = TimeOfDay(hour: 18, minute: 10);
  RangeValues _rangeValues = RangeValues(20, 80);
  List _category = [];
  List _service = [];
  List<Color> _colorSelected = [];
  double _rate = 4;
  String _currency = String.fromCharCode(0x24);

  @override
  void initState() {
    super.initState();
  }

  ///Show Picker Time
  Future<void> _showTimePicker(BuildContext context, TimeType type) async {
    final picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (type == TimeType.start && picked != null) {
      setState(() {
        _startHour = picked;
      });
    }
    if (type == TimeType.end && picked != null) {
      setState(() {
        _endHour = picked;
      });
    }
  }

  ///On Navigate Filter location
  Future<void> _onNavigateLocation() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.chooseLocation,
      arguments: _locationSelected,
    );
    if (result != null) {
      setState(() {
        _locationSelected = result;
      });
    }
  }

  ///On Navigate Filter location
  Future<void> _onNavigateArea() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.chooseLocation,
      arguments: _areaSelected,
    );
    if (result != null) {
      setState(() {
        _areaSelected = result;
      });
    }
  }

  String _buildLocationText() {
    List<String> locationListText = [];
    _locationSelected.forEach((item) {
      locationListText.add(item.name);
    });
    return locationListText.join(',');
  }

  String _buildAreaText() {
    List<String> locationListText = [];
    _areaSelected.forEach((item) {
      locationListText.add(item.name);
    });
    return locationListText.join(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('filter'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              Translate.of(context).translate('apply'),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('category'),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _filterPage.category.map((item) {
                          final bool selected = _category.contains(item);
                          return FilterChip(
                            padding: EdgeInsets.zero,
                            selected: selected,
                            label: Text(item),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onSelected: (value) {
                              selected
                                  ? _category.remove(item)
                                  : _category.add(item);
                              setState(() {
                                _category = _category;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                          top: 16,
                        ),
                        child: Text(
                          Translate.of(context).translate('facilities'),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _filterPage.service.map((item) {
                          final bool selected = _service.contains(item);
                          return FilterChip(
                            selected: selected,
                            label: Text(item),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onSelected: (value) {
                              selected
                                  ? _service.remove(item)
                                  : _service.add(item);
                              setState(() {
                                _service = _service;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: _onNavigateLocation,
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        Translate.of(context)
                                            .translate('location'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      _locationSelected.isEmpty
                                          ? Padding(
                                              padding: EdgeInsets.only(top: 4),
                                              child: Text(
                                                Translate.of(context).translate(
                                                  'select_location',
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(top: 4),
                                              child: Text(
                                                _buildLocationText(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  textDirection: TextDirection.ltr,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: _onNavigateArea,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      Translate.of(context).translate('area'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    _areaSelected.isEmpty
                                        ? Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              Translate.of(context)
                                                  .translate('select_location'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              _buildAreaText(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                textDirection: TextDirection.ltr,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('price_range'),
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '$_currency 0',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  '$_currency 100',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 20,
                    child: RangeSlider(
                      min: 0,
                      max: 100,
                      values: _rangeValues,
                      onChanged: (range) {
                        setState(() {
                          _rangeValues = range;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('avg_price'),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        '${_rangeValues.start.round()}$_currency- ${_rangeValues.end.round()}$_currency',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                          top: 16,
                        ),
                        child: Text(
                          Translate.of(context).translate('business_color'),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: _color.map((item) {
                          final selected = _colorSelected.contains(item);
                          return InkWell(
                            onTap: () {
                              selected
                                  ? _colorSelected.remove(item)
                                  : _colorSelected.add(item);
                              setState(() {
                                _colorSelected = _colorSelected;
                              });
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item,
                              ),
                              child: selected
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : Container(),
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                          top: 16,
                        ),
                        child: Text(
                          Translate.of(context).translate('open_time'),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _showTimePicker(context, TimeType.start);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        Translate.of(context).translate(
                                          'start_time',
                                        ),
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${_startHour.hour}:${_startHour.minute}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              VerticalDivider(),
                              SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      _showTimePicker(context, TimeType.end);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          Translate.of(context).translate(
                                            'end_time',
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${_endHour.hour}:${_endHour.minute}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                          top: 16,
                        ),
                        child: Text(
                          Translate.of(context).translate('rating'),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      RatingBar.builder(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
