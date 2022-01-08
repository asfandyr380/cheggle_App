import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/widgets/app_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UploadContent extends StatefulWidget {
  UploadContent({@required this.package});
  final Map package;
  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  List _pricing_list = [];

  Map _selectedPackage;
  bool _privacyPolicy = false;
  bool _terms = false;

  ImagePicker picker = ImagePicker();
  int progress = 0;
  bool isLoading = false;

  setBusy(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  Future pickVideo() async {
    progress = 0;
    XFile _pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (_pickedFile != null) {
      uploadVideo(_pickedFile, uploadNotifier: (value) {
        setState(() {
          progress = value;
        });
      });
    }
  }

  Future uploadVideo(XFile file, {dynamic uploadNotifier(int progress)}) async {
    Uint8List byteFile = await file.readAsBytes();
    String bearer = "bearer 4751b7865a4d5588920fc23952c16ee8";
    try {
      // Create Upload File
      var response = await Dio().post('https://api.vimeo.com/me/videos',
          data: {
            "upload": {"approach": "tus", "size": "${byteFile.lengthInBytes}"},
            "name": "${file.name}"
          },
          options: Options(
            headers: {
              "Authorization": bearer,
              "Content-Type": "application/json",
              "Accept": "application/vnd.vimeo.*+json;version=3.4"
            },
          ));
      final Map parsed = json.decode(response.data);
      final upload_link = parsed['upload']['upload_link'];
      // Upload File for real
      await Dio().patch(
        upload_link,
        data: Stream.fromIterable(byteFile.map((e) => [e])),
        options: Options(
          headers: {
            "Content-Length": "${byteFile.lengthInBytes}",
            "Tus-Resumable": "1.0.0",
            "Upload-Offset": "0",
            "Content-Type": "application/offset+octet-stream",
            "Accept": "application/vnd.vimeo.*+json;version=3.4",
          },
        ),
        onSendProgress: (int sent, int total) {
          final progress = ((sent / total) * 100).floor();
          uploadNotifier(progress);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  _selectPackage(Map map) {
    _selectedPackage = map;
    _pricing_list.forEach((e) {
      if (e['title'] == map['title']) {
        setState(() {
          if (e['isSelected'] == true) {
            e['isSelected'] = false;
            _selectedPackage = null;
          } else
            e['isSelected'] = true;
        });
      } else {
        setState(() {
          e['isSelected'] = false;
        });
      }
    });
  }

  _continue() async {
    if (_privacyPolicy && _terms) {
      Map data = {
        "Package": widget.package['card'],
        "Additional_Service": _selectedPackage,
        'form_data': widget.package['form_data'],
      };
      Navigator.pushReplacementNamed(context, Routes.cashBox, arguments: data);
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    setBusy(true);
    var http = HTTPManager();
    var result = await http.get(url: "$BASE_URL/packages/vPackages");
    if (result['success']) {
      setState(() {
        _pricing_list = result['data'];
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
          Translate.of(context).translate('Upload'),
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
                  padding: EdgeInsets.only(bottom: 10.0, top: 16),
                  child: Text(
                    Translate.of(context).translate('Upload Video'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Do you already have a video? very good Then you can now load this directly onto your new customer profile as a start video.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.3),
                  ),
                ),
                AppButton(
                  Translate.of(context).translate('Upload'),
                  onPressed: () => pickVideo(),
                  loading: false,
                  disabled: false,
                ),
                SizedBox(height: 10),
                progress != 0
                    ? Center(
                        child: SizedBox(
                          width: 50,
                          height: 60,
                          child: CircularPercentIndicator(
                            radius: 60,
                            progressColor: Theme.of(context).primaryColor,
                            center: Text('$progress'),
                            percent: progress / 100,
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    Translate.of(context).translate('Order Video'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "you dont have your own video yet? No Problem. we create videos for you and your customers.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "choose one from out package:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.3, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // ignore: sdk_version_ui_as_code
                      for (var p in _pricing_list)
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () => _selectPackage(p),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VideoCard(
                                    price: p['price'].toStringAsFixed(2),
                                    title: p['title'],
                                    isSelected: p['isSelected'],
                                    imagePath: "$BASE_URL_Img/${p['imagePath']}",
                                    desc: p['desc'],
                                  ),
                                ),
                              ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        value: _privacyPolicy,
                        onChanged: (state) {
                          setState(() {
                            _privacyPolicy = state;
                          });
                        }),
                    Text('I have read the'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.privacyPolicy);
                        },
                        child: Text('Privacy Policy.'))
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _terms,
                        onChanged: (state) {
                          setState(() {
                            _terms = state;
                          });
                        }),
                    Text('I have read the'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.termsServices);
                        },
                        child: Text('General')),
                    Text('terms and conditions'),
                  ],
                ),
                SizedBox(height: 10),
                AppButton(
                  Translate.of(context).translate('Continue'),
                  onPressed: () => _continue(),
                  loading: false,
                  disabled: (_privacyPolicy && _terms) ? false : true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard(
      {@required this.price,
      @required this.title,
      @required this.desc,
      @required this.isSelected,
      @required this.imagePath});
  final String title;
  final String price;
  final bool isSelected;
  final String imagePath;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Theme.of(context).primaryColor)
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "$title (€ $price)",
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          TextButton(
            child: Text(
              'Learn More',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            onPressed: () => showDialog(
                context: context, builder: (_) => LearnMoreDialog(desc: desc)),
          ),
        ],
      ),
    );
  }
}

class LearnMoreDialog extends StatelessWidget {
  final String desc;
  LearnMoreDialog({@required this.desc});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Learn More",
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(fontWeight: FontWeight.w600),
      ),
      content: Text(
        desc,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Close"))
      ],
    );
  }
}
