import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/screens/screen.dart';
import 'package:listar_flutter/utils/utils.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  ///On change tab bottom menu
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///Home Screen For Your Business
  Widget _homeForBusiness(BusinessState business) {
    switch (business) {
      case BusinessState.realEstate:
        return HomeRealEstate();
      case BusinessState.event:
        return HomeEvent();
      case BusinessState.food:
        return HomeFood();
      default:
        return Home();
    }
  }

  ///WishList Screen For Your Business
  Widget _wishListForBusiness(BusinessState business) {
    switch (business) {
      case BusinessState.realEstate:
        return WishListRealEstate();
      case BusinessState.event:
        return WishListEvent();
      case BusinessState.food:
        return WishListFood();
      default:
        return WishList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BusinessCubit, BusinessState>(
        builder: (context, business) {
          return BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, auth) {
              return IndexedStack(
                index: _selectedIndex,
                children: <Widget>[
                  _homeForBusiness(business),
                  _wishListForBusiness(business),
                  MessageList(),
                  NotificationList(),
                  auth is AuthenticationSuccess ? Profile() : SignIn()
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Translate.of(context).translate('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: Translate.of(context).translate('wish_list'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: Translate.of(context).translate('message'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: Translate.of(context).translate('notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: Translate.of(context).translate('account'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
