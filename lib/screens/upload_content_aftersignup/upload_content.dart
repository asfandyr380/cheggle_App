import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/widgets/app_button.dart';

class UploadContent extends StatefulWidget {
  UploadContent({@required this.package});
  final Map package;
  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  List<Map> _pricing_list = [
    {
      'price': "199.00",
      'title': 'CHEGGLE CLIP',
      'isSelected': false,
      'imagePath': "assets/images/webpc-passthru.webp",
      'desc':
          "Your product in focus. Ideal for campaigns, invitations, tips, etc. 1 professional marketing spot (10 seconds in length) Preparation for shooting with a Cheggl contact person, approx. 15 minutes of shooting on site Post-production including editing, color matching and setting of music licensed by Cheggl including all costs for the video equipment 1 location (free travel up to 15 km) 1 feedback loop before approval"
    },
    {
      'price': "99.00",
      'title': 'CHEGGLE SPOT',
      'isSelected': false,
      'imagePath': "assets/images/webpc-passthru (1).webp",
      'desc':
          'No time for a shoot? Does not matter! We also produce “remotely” for you. 1 professional video slider (15 seconds long) permanent contact from Cheggl Production with stock material and files supplied (photos, texts) including editing music licensed by Cheggl 1 feedback loop before approval no follow-up costs problem-free publication on your own website and social media platforms (Facebook, Whatsapp, youtube, Instagram)'
    },
    {
      'price': "79.00",
      'title': 'CHEGGLE SLIDER',
      'isSelected': false,
      'imagePath': "assets/images/webpc-passthru (2).webp",
      'desc':
          'Your company as a video in 30 seconds. The classic at an unbeatable top price! Your company in a high quality marketing video. Ideal for image films, product launches, explanatory videos, documentaries, etc.'
    }
  ];

  Map _selectedPackage;
  bool _privacyPolicy = false;
  bool _terms = false;

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
      Map data = {"Package": widget.package, "Additional_Service": _selectedPackage};
      Navigator.pushReplacementNamed(context, Routes.cashBox, arguments: data);
    }
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
                  onPressed: () {},
                  loading: false,
                  disabled: false,
                ),
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
                        GestureDetector(
                          onTap: () => _selectPackage(p),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VideoCard(
                              price: p['price'],
                              title: p['title'],
                              isSelected: p['isSelected'],
                              imagePath: p['imagePath'],
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
                image: AssetImage(imagePath),
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
