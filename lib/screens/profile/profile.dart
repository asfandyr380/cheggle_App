// ignore_for_file: sdk_version_ui_as_code

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

enum ProfileType { basic, premium }

class Profile extends StatefulWidget {
  final bool preview;
  Profile({this.preview});

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  final _bannerAd = BannerAd(
    adUnitId: Ads.bannerAdUnitId,
    size: AdSize.mediumRectangle,
    request: AdRequest(),
    listener: AdListener(
      onAdLoaded: (Ad ad) {},
      onAdFailedToLoad: (ad, error) {},
      onAdOpened: (Ad ad) => UtilLogger.log("DEBUGGGGG", 3),
      onAdClosed: (Ad ad) => UtilLogger.log("DEBUGGGGG", 4),
      onApplicationExit: (Ad ad) => UtilLogger.log("DEBUGGGGG", 5),
    ),
  );

  ProfilePageModel _profilePage;
  bool isInitialized = false;
  bool preview = false;
  ProfileType _type;
  var tabController;
  int tabs = 1;
  List<String> tabslist = [];
  List<Widget> tabslist_content = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      preview = widget.preview ?? false;
    });
    _loadData();
    _bannerAd?.load();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getProfile();
    if (result.success) {
      setState(() {
        _profilePage = ProfilePageModel.fromJson(result.data);
      });
      if (_profilePage.user.roles.contains('ROLE_moderator')) {
        _type = ProfileType.premium;
      } else {
        _type = ProfileType.basic;
      }
      calculateTabs();
    }
    setState(() {
      isInitialized = true;
    });
  }

  calculateTabs() {
    if (_profilePage.user.reviews.length != 0) {
      setState(() {
        tabslist.add("Ratings");
        tabslist_content.add(_buildReviewList());
        tabs++;
      });
    }
    if (_profilePage.user.servies.length != 0) {
      setState(() {
        tabslist.add("Services");
        tabslist_content.add(_buildServicesList());

        tabs++;
      });
    }
    if (_profilePage.user.partners.length != 0) {
      setState(() {
        tabslist.add("Partners");
        tabslist_content.add(_buildPartners());

        tabs++;
      });
    }
    if (_profilePage.user.aboutUs != "") {
      setState(() {
        tabslist.add("About Us");
        tabslist_content.add(_buildAboutUs());
        tabs++;
      });
    }
  }

  ///On logout
  Future<void> _logout() async {
    AppBloc.loginBloc.add(OnLogout());
  }

  ///Build profile UI
  // Widget _buildProfile() {
  //   return AppUserInfo(
  //     user: _profilePage?.user,
  //     onPressed: () {},
  //     type: AppUserType.information,
  //   );
  // }

  ///Build value
  // Widget _buildValue() {
  //   return AppProfilePerformance(
  //     data: _profilePage?.value,
  //     onPressed: (item) {},
  //   );
  // }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Profile':
        _onNavigate(Routes.editProfile);
        break;
      case 'Share':
        break;
      case 'Map':
        Navigator.pushNamed(context, Routes.location,
            arguments: LocationModel(1, 'loc', 37.774929, -122.419418));
        break;
      case 'Logout':
        _logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized
        ? _type == ProfileType.basic
            ? Scaffold(
                body: DefaultTabController(
                  length: tabs,
                  child: NestedScrollView(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                        expandedHeight: 250.0,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          PopupMenuButton<String>(
                            onSelected: (_) => handleClick(_),
                            itemBuilder: (BuildContext context) {
                              return {'Profile', 'Share', 'Map', 'Logout'}
                                  .map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: _profilePage != null
                              ? ProfileHeader(user: _profilePage.user)
                              : Container(),
                        ),
                        pinned: true,
                      ),
                    ],
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Updgrade to Premium',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                          SizedBox(height: 30),
                          AppButton(
                            Translate.of(context)
                                .translate('Upgrade to Premium'),
                            onPressed: () {},
                            loading: false,
                            disabled: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                body: DefaultTabController(
                  length: tabs,
                  child: NestedScrollView(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                        expandedHeight: 250.0,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          PopupMenuButton<String>(
                            onSelected: (_) => handleClick(_),
                            itemBuilder: (BuildContext context) {
                              return {'Profile', 'Share', 'Map', 'Logout'}
                                  .map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: _profilePage != null
                              ? ProfileHeader(user: _profilePage.user)
                              : Container(),
                        ),
                        pinned: true,
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            indicatorColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Theme.of(context).primaryColor.withAlpha(120),
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: [
                              for (var tab in tabslist) Tab(text: tab),
                              Tab(text: "Events"),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ],
                    body: TabBarView(
                      children: [
                        for (var tab in tabslist_content) tab,
                        Text('Events'),
                      ],
                    ),
                  ),
                ),
              )
        : Center(child: CircularProgressIndicator());
  }

  ///Build list
  Widget _buildReviewList() {
    if (_profilePage.user.reviews == null) {
      return ListView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        children: List.generate(
          8,
          (item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AppCommentItem(),
            );
          },
        ).toList(),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      itemCount: _profilePage.user.reviews.length,
      itemBuilder: (context, index) {
        final item = _profilePage.user.reviews[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppCommentItem(item: item),
        );
      },
    );
  }

  Widget _buildServicesList() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        for (var service in _profilePage.user.servies)
          ServicesCard(service: service),
      ],
    );
  }

  Widget _buildAboutUs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _profilePage.user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _profilePage.user.aboutUs,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartners() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        for (var partner in _profilePage.user.partners)
          PartnerCard(partner: partner),
      ],
    );
  }

  Widget _buildEvents() {
    return Column();
  }
}

class PartnerCard extends StatelessWidget {
  final String partner;
  const PartnerCard({this.partner});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 15,
        ),
        SizedBox(width: 15),
        Expanded(
            child: Text(
          partner.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
}

class ServicesCard extends StatelessWidget {
  final String service;
  ServicesCard({this.service});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            service,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  ProfileHeader({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/images/real-estate-7.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(0.4),
          colorBlendMode: BlendMode.darken,
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.companyName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 3,
                      width: 100,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      onRatingUpdate: (_) {},
                      initialRating: 1.5,
                      minRating: 1,
                      allowHalfRating: true,
                      unratedColor: Colors.white.withAlpha(100),
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      ignoreGestures: true,
                    ),
                    SizedBox(height: 10),
                    _buildContactInfo(
                        icon: Icons.location_on, text: user.address),
                    SizedBox(height: 10),
                    _buildContactInfo(icon: Icons.phone, text: user.phone),
                    SizedBox(height: 10),
                    _buildContactInfo(icon: Icons.email, text: user.email),
                    SizedBox(height: 10),
                    _buildContactInfo(icon: Icons.web, text: user.website)
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildContactInfo({IconData icon, String text}) => Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}



// Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text(
//                 Translate.of(context).translate('profile'),
//               ),
//             ),
//             body: SafeArea(
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: ListView(
//                       padding: EdgeInsets.only(
//                         top: 16,
//                       ),
//                       children: <Widget>[
//                         Padding(
//                           padding:
//                               EdgeInsets.only(left: 16, right: 16, bottom: 16),
//                           child: Column(
//                             children: <Widget>[
//                               _buildProfile(),
//                               // _buildValue(),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 16, right: 16),
//                           child: Column(
//                             children: <Widget>[
//                               AppListTitle(
//                                 title: Translate.of(context).translate(
//                                   'edit_profile',
//                                 ),
//                                 trailing: RotatedBox(
//                                   quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right,
//                                     textDirection: TextDirection.ltr,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   _onNavigate(Routes.editProfile);
//                                 },
//                               ),
//                               Divider(),
//                               AppListTitle(
//                                 title: Translate.of(context).translate(
//                                   'change_password',
//                                 ),
//                                 trailing: RotatedBox(
//                                   quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right,
//                                     textDirection: TextDirection.ltr,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   _onNavigate(Routes.changePassword);
//                                 },
//                               ),
//                               Divider(),
//                               AppListTitle(
//                                 title: Translate.of(context)
//                                     .translate('contact_us'),
//                                 onPressed: () {
//                                   _onNavigate(Routes.contactUs);
//                                 },
//                                 trailing: RotatedBox(
//                                   quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right,
//                                     textDirection: TextDirection.ltr,
//                                   ),
//                                 ),
//                               ),
//                               Divider(),
//                               AppListTitle(
//                                 title: Translate.of(context).translate(
//                                   'about_us',
//                                 ),
//                                 onPressed: () {
//                                   _onNavigate(Routes.aboutUs);
//                                 },
//                                 trailing: RotatedBox(
//                                   quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right,
//                                     textDirection: TextDirection.ltr,
//                                   ),
//                                 ),
//                               ),
//                               Divider(),
//                               AppListTitle(
//                                 title:
//                                     Translate.of(context).translate('setting'),
//                                 onPressed: () {
//                                   _onNavigate(Routes.setting);
//                                 },
//                                 trailing: RotatedBox(
//                                   quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right,
//                                     textDirection: TextDirection.ltr,
//                                   ),
//                                 ),
//                               ),
//                               Divider(),
//                               Container(
//                                 width: _bannerAd.size.width.toDouble(),
//                                 height: _bannerAd.size.height.toDouble(),
//                                 child: AdWidget(ad: _bannerAd),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(16),
//                     child: AppButton(
//                       Translate.of(context).translate('sign_out'),
//                       onPressed: _logout,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )