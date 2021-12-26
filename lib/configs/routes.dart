import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/add_address/add_address.dart';
import 'package:listar_flutter/screens/cashbox/cashbox.dart';
import 'package:listar_flutter/screens/privacy_policy/privacy_policy.dart';
import 'package:listar_flutter/screens/profileSetup/profilesetup.dart';
import 'package:listar_flutter/screens/screen.dart';
import 'package:listar_flutter/screens/select_package/selectPackage.dart';
import 'package:listar_flutter/screens/terms_services/terms_services.dart';
import 'package:listar_flutter/screens/upload_content_aftersignup/upload_content.dart';

class Routes {
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";
  static const String notification = "/notification";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String chat = "/chat";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String photoPreview = "/photoPreview";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filter = "/filter";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String location = "/location";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String chooseLocation = "/chooseLocation";
  static const String uploadContent = "/upload";
  static const String privacyPolicy = "/policy";
  static const String termsServices = "/terms";
  static const String selectPackage = "/packages";
  static const String cashBox = "/cashbox";
  static const String addAddress = "/address";
  static const String profileSetup = "/setup";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return SignIn();
          },
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return SignUp();
          },
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return ForgotPassword();
          },
        );

      case productDetail:
        return MaterialPageRoute(
          builder: (context) {
            switch (AppBloc.businessCubit.state) {
              case BusinessState.realEstate:
                final item = settings.arguments as ProductRealEstateModel;
                return ProductDetailRealEstate(id: item.id);

              case BusinessState.event:
                final item = settings.arguments as ProductEventModel;
                return ProductDetailEvent(id: item.id);

              case BusinessState.food:
                final item = settings.arguments as ProductFoodModel;
                return ProductDetailFood(id: item.id);

              default:
                final item = settings.arguments as ProductModel;
                if (item.viewStyle == DetailViewStyle.tab) {
                  return ProductDetailTab(id: item.id);
                }
                return ProductDetail(id: item.id);
            }
          },
        );

      case searchHistory:
        return MaterialPageRoute(
          builder: (context) {
            switch (AppBloc.businessCubit.state) {
              case BusinessState.realEstate:
                return SearchHistoryRealEstate();
              case BusinessState.event:
                return SearchHistoryEvent();
              case BusinessState.food:
                return SearchHistoryFood();
              default:
                return SearchHistory();
            }
          },
          fullscreenDialog: true,
        );

      case category:
        return MaterialPageRoute(
          builder: (context) {
            return Category();
          },
        );

      case notification:
        return MaterialPageRoute(
          builder: (context) => NotificationList(),
          fullscreenDialog: true,
        );

      case chat:
        final id = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Chat(
            id: id,
          ),
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return EditProfile();
          },
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return ChangePassword();
          },
        );

      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return LanguageSetting();
          },
        );

      case contactUs:
        return MaterialPageRoute(
          builder: (context) {
            return ContactUs();
          },
        );

      case aboutUs:
        return MaterialPageRoute(
          builder: (context) {
            return AboutUs();
          },
        );

      case themeSetting:
        return MaterialPageRoute(
          builder: (context) {
            return ThemeSetting();
          },
        );

      case filter:
        return MaterialPageRoute(
          builder: (context) => Filter(),
          fullscreenDialog: true,
        );

      case review:
        return MaterialPageRoute(
          builder: (context) {
            return Review();
          },
        );

      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return Setting();
          },
        );

      case fontSetting:
        return MaterialPageRoute(
          builder: (context) {
            return FontSetting();
          },
        );

      case writeReview:
        final author = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => WriteReview(
            author: author,
          ),
        );

      case location:
        final location = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Location(
            location: location,
          ),
        );

      case listProduct:
        final category = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            switch (AppBloc.businessCubit.state) {
              case BusinessState.realEstate:
                return ListProductRealEstate(title: category);
              case BusinessState.event:
                return ListProductEvent(title: category);
              case BusinessState.food:
                return ListProductFood(title: category);
              default:
                return ListProduct(title: category);
            }
          },
        );
      case gallery:
        final photo = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Gallery(photo: photo),
          fullscreenDialog: true,
        );

      case photoPreview:
        final Map<String, dynamic> params = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => PhotoPreview(
            galleryList: params['photo'],
            initialIndex: params['index'],
          ),
          fullscreenDialog: true,
        );

      case chooseLocation:
        final location = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return ChooseLocation(location: location);
          },
        );

      case uploadContent:
        final package = settings.arguments;

        return MaterialPageRoute(
          builder: (context) {
            return UploadContent(package: package);
          },
        );

      case privacyPolicy:
        return MaterialPageRoute(
          builder: (context) {
            return PrivacyPolicy();
          },
        );

      case termsServices:
        return MaterialPageRoute(
          builder: (context) {
            return TermsServices();
          },
        );

      case selectPackage:
        Map data = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return SelectPackage(data: data);
          },
        );

      case cashBox:
        final data = settings.arguments;

        return MaterialPageRoute(
          builder: (context) {
            return CashBox(data: data);
          },
        );

      case addAddress:
        return MaterialPageRoute(
          builder: (context) {
            return AddAdress();
          },
        );

      case profileSetup:
        final id = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return ProfileSetup(id: id);
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
