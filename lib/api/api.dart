import 'dart:async';
import 'package:dio/dio.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/repository/user.dart';
import 'package:listar_flutter/screens/change_password/change_password.dart';
import 'package:listar_flutter/utils/utils.dart';

const String BASE_URL = "http://192.168.100.8:3000/api";
const String BASE_URL_Img = "http://192.168.100.8:3000/uploads/";

class Api {
  ///URL API
  static const String AUTH_LOGIN = "/jwt-auth/v1/token";
  static const String AUTH_VALIDATE = "/jwt-auth/v1/token/validate";
  static const String GET_SETTING = "/listar/v1/setting/init";

  ///Login api
  static Future<dynamic> login({String username, String password}) async {
    // final result = await UtilData.login();
    final http = HTTPManager();

    final result = await http.post(
      url: '$BASE_URL/auth/signin',
      data: {
        'email': username,
        'password': password,
      },
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<dynamic> uploadProfileImg({String id, String filePath}) async {
    // final result = await UtilData.login();
    final http = HTTPManager();
    var formData = FormData.fromMap({
      'id': id,
      'file': await MultipartFile.fromFile(
        filePath,
        filename: 'image.jpg',
      )
    });

    final result = await http.post(
      url: '$BASE_URL/user/profile/upload',
      data: formData,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<dynamic> updateProfile(
      {String id,
      String firstName,
      String lastName,
      String email,
      String address,
      String website}) async {
    // final result = await UtilData.login();
    final http = HTTPManager();

    final result = await http.post(
      url: '$BASE_URL/user/update',
      data: {
        'id': id,
        'fistname': firstName,
        'lastname': lastName,
        'email': email,
        'street': address,
        'website': website,
      },
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<dynamic> changePassword(String id, String password) async {
    await Future.delayed(Duration(seconds: 1));
    // final result = await UtilData.getProfile();
    final userRepository = UserRepository();
    UserModel user = await userRepository.getUser();
    final http = HTTPManager();
    final result = await http.post(
        url: '$BASE_URL/user/profile/changePass',
        data: {"id": id, "password": password});
    return ResultApiModel.fromJson(result);
  }

  ///Validate token valid
  static Future<dynamic> validateToken() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.validateToken();
    return ResultApiModel.fromJson(result);
  }

  ///Get Profile Detail
  static Future<dynamic> getProfile() async {
    await Future.delayed(Duration(seconds: 1));
    // final result = await UtilData.getProfile();
    final userRepository = UserRepository();
    UserModel user = await userRepository.getUser();
    final http = HTTPManager();
    final result = await http.get(url: '$BASE_URL/user/${user.id}');
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<dynamic> getCategory() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getCategory();
    return ResultApiModel.fromJson(result);
  }

  ///Get About Us
  static Future<dynamic> getAboutUs() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getAboutUs();
    return ResultApiModel.fromJson(result);
  }

  ///Get Home
  static Future<dynamic> getHome() async {
    await Future.delayed(Duration(seconds: 1));
    var result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getHomeRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getHomeEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getHomeFood();
        break;
      default:
        result = await UtilData.getHomeBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Messages
  static Future<dynamic> getMessage() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getMessage();
    return ResultApiModel.fromJson(result);
  }

  ///Get Detail Messages
  static Future<dynamic> getDetailMessage({int id}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getDetailMessage(id);
    return ResultApiModel.fromJson(result);
  }

  ///Get Notification
  static Future<dynamic> getNotification() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getNotification();
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail and Product Detail Tab
  static Future<dynamic> getProductDetail({String id}) async {
    var result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getProductDetailRealEstate(
          id: id,
          jsonResultApi: true,
        );
        break;
      case BusinessState.event:
        result = await UtilData.getProductDetailEvent(
          id: id,
          jsonResultApi: true,
        );
        break;
      case BusinessState.food:
        result = await UtilData.getProductDetailFood(
          id: id,
          jsonResultApi: true,
        );
        break;
      default:
        result = await UtilData.getProductDetailBasic(
          id: id,
          jsonResultApi: true,
        );
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get History Search
  static Future<dynamic> getHistorySearch() async {
    await Future.delayed(Duration(seconds: 1));
    var result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getHistorySearchRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getHistorySearchEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getHistorySearchFood();
        break;
      default:
        result = await UtilData.getHistorySearchBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Wish List
  static Future<dynamic> getWishList() async {
    await Future.delayed(Duration(seconds: 1));
    var result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getWishListRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getWishListEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getWishListFood();
        break;
      default:
        result = await UtilData.getWishList();
    }
    return ResultApiModel.fromJson(result);
  }

  ///On Search
  static Future<dynamic> onSearchData() async {
    await Future.delayed(Duration(seconds: 1));
    var result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getProductRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getProductEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getProductFood();
        break;
      default:
        result = await UtilData.getProductBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Location List
  static Future<dynamic> getLocationList() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getLocationList();
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<dynamic> getProduct() async {
    var result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getProductRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getProductEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getProductFood();
        break;
      default:
        result = await UtilData.getProductBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Review
  static Future<dynamic> getReview() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilData.getReview();
    return ResultApiModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
