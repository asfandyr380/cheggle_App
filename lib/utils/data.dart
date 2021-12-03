import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/models/model_user.dart';
import 'package:listar_flutter/repository/user.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'dart:developer';

class UtilData {
  static Future<Map<String, dynamic>> login() async {
    return await UtilAsset.loadJson("assets/data/login.json");
  }

  static Future<Map<String, dynamic>> validateToken() async {
    return await UtilAsset.loadJson("assets/data/valid_token.json");
  }

  static Future<Map<String, dynamic>> getProfile() async {
    return await UtilAsset.loadJson("assets/data/profile.json");
  }

  static Future<Map<String, dynamic>> getCategory() async {
    return await UtilAsset.loadJson("assets/data/category.json");
  }

  static Future<Map<String, dynamic>> getAboutUs() async {
    return await UtilAsset.loadJson("assets/data/about_us.json");
  }

  static Future<Map<String, dynamic>> getMessage() async {
    return await UtilAsset.loadJson("assets/data/message.json");
  }

  static Future<Map<String, dynamic>> getDetailMessage(int id) async {
    return await UtilAsset.loadJson(
      "assets/data/message_detail_$id.json",
    );
  }

  static Future<Map<String, dynamic>> getNotification() async {
    return await UtilAsset.loadJson("assets/data/notification.json");
  }

  static Future<Map<String, dynamic>> getLocationList() async {
    return await UtilAsset.loadJson("assets/data/location.json");
  }

  static Future<Map<String, dynamic>> getReview() async {
    return await UtilAsset.loadJson("assets/data/review.json");
  }

  ///Home Basic
  static Future<Map<String, dynamic>> getHomeBasic() async {
    var result = await UtilAsset.loadJson("assets/data/home.json");
    var http = HTTPManager();

    final res_featured = await http.get(url: '$BASE_URL/product/featured');
    if (res_featured['success']) {
      result['data']['popular'] = res_featured['data'];
    }

    final res_recent = await http.get(url: '$BASE_URL/product/recent');
    if (res_recent['success']) {
      result['data']['list'] = res_recent['data'];
    }

    // result['data']['list'] = [
    //   await getProductDetailBasic(id: "1"),
    //   await getProductDetailBasic(id: "2"),
    //   // await getProductDetailBasic(id: "3"),
    //   // await getProductDetailBasic(id: "3"),
    //   // await getProductDetailBasic(id: "5"),
    //   // await getProductDetailBasic(id: "6"),
    //   // await getProductDetailBasic(id: "7"),
    //   // await getProductDetailBasic(id: "8"),
    //   // await getProductDetailBasic(id: "9"),
    //   // await getProductDetailBasic(id: "10"),
    //   // await getProductDetailBasic(id: "11"),
    //   // await getProductDetailBasic(id: "12"),
    //   // await getProductDetailBasic(id: "13"),
    //   // await getProductDetailBasic(id: "14"),
    //   // await getProductDetailBasic(id: "15"),
    // ];
    return result;
  }

  ///Home Real Estate
  static Future<Map<String, dynamic>> getHomeRealEstate() async {
    var result = await UtilAsset.loadJson("assets/data/home_real_estate.json");
    result['data']['popular'] = [
      await getProductDetailRealEstate(id: '1'),
      await getProductDetailRealEstate(id: '2'),
      await getProductDetailRealEstate(id: '3'),
      await getProductDetailRealEstate(id: '4'),
    ];
    result['data']['recommend'] = [
      await getProductDetailRealEstate(id: '5'),
      await getProductDetailRealEstate(id: '6'),
      await getProductDetailRealEstate(id: '7'),
      await getProductDetailRealEstate(id: '8'),
    ];
    return result;
  }

  ///Home Event
  static Future<Map<String, dynamic>> getHomeEvent() async {
    var result = await UtilAsset.loadJson("assets/data/home_event.json");
    result['data']['feature'] = [
      await getProductDetailEvent(id: "4"),
      await getProductDetailEvent(id: "6"),
      await getProductDetailEvent(id: "5"),
      await getProductDetailEvent(id: "1"),
    ];
    result['data']['new'] = [
      await getProductDetailEvent(id: "2"),
      await getProductDetailEvent(id: "3"),
      await getProductDetailEvent(id: "7"),
      await getProductDetailEvent(id: "8"),
    ];
    return result;
  }

  ///Home Event
  static Future<Map<String, dynamic>> getHomeFood() async {
    var result = await UtilAsset.loadJson("assets/data/home_food.json");
    result['data']['banners'] = [
      await getProductDetailFood(id: "1"),
      await getProductDetailFood(id: "2"),
      await getProductDetailFood(id: "3"),
    ];
    result['data']['recommends'] = [
      await getProductDetailFood(id: "3"),
      await getProductDetailFood(id: "2"),
      await getProductDetailFood(id: "1"),
    ];
    result['data']['locations'] = [
      await getProductDetailFood(id: "4"),
      await getProductDetailFood(id: "5"),
      await getProductDetailFood(id: "6"),
      await getProductDetailFood(id: "7"),
    ];
    return result;
  }

  ///Product Detail Basic
  static Future<Map<String, dynamic>> getProductDetailBasic({
    String id,
    bool jsonResultApi = false,
  }) async {
    var tabs = await UtilAsset.loadJson(
      "assets/data/tabs.json",
    );

    var http = HTTPManager();

    Map result = await http.get(url: '$BASE_URL/product/$id');
    if (result['success']) {
      // tabs = result['data'];
      result['data']['tab'] = tabs['tabs'];
      if (jsonResultApi) {
        return {
          "success": true,
          "data": result['data'],
          "message": "get data success"
        };
      }
      return result['data'];
    }
  }

  ///Product Detail Real Estate
  static Future<Map<String, dynamic>> getProductDetailRealEstate({
    String id,
    bool jsonResultApi = false,
  }) async {
    final result = await UtilAsset.loadJson(
      "assets/data/product_detail_real_estate_$id.json",
    );
    if (jsonResultApi) {
      return {"success": true, "data": result, "message": "get data success"};
    }
    return result;
  }

  ///Product Detail Real Estate
  static Future<Map<String, dynamic>> getProductDetailEvent({
    String id,
    bool jsonResultApi = false,
  }) async {
    final result = await UtilAsset.loadJson(
      "assets/data/product_detail_event_$id.json",
    );
    if (jsonResultApi) {
      return {"success": true, "data": result, "message": "get data success"};
    }
    return result;
  }

  ///Product Detail Food
  static Future<Map<String, dynamic>> getProductDetailFood({
    String id,
    bool jsonResultApi = false,
  }) async {
    UtilLogger.log("CCC", id);
    final result = await UtilAsset.loadJson(
      "assets/data/product_detail_food_$id.json",
    );
    if (jsonResultApi) {
      return {"success": true, "data": result, "message": "get data success"};
    }
    return result;
  }

  ///History Search Basic
  static Future<Map<String, dynamic>> getHistorySearchBasic() async {
    var result = await UtilAsset.loadJson("assets/data/search_history.json");
    result['data']['history'] = [
      await getProductDetailBasic(id: "1"),
      await getProductDetailBasic(id: "2"),
      await getProductDetailBasic(id: "3"),
      await getProductDetailBasic(id: "3"),
      await getProductDetailBasic(id: "5"),
      await getProductDetailBasic(id: "6"),
      await getProductDetailBasic(id: "7"),
      await getProductDetailBasic(id: "8"),
      await getProductDetailBasic(id: "9"),
      await getProductDetailBasic(id: "10"),
      await getProductDetailBasic(id: "11"),
      await getProductDetailBasic(id: "12"),
      await getProductDetailBasic(id: "13"),
      await getProductDetailBasic(id: "14"),
      await getProductDetailBasic(id: "15"),
    ];
    result['data']['recently'] = [
      await getProductDetailBasic(id: "11"),
      await getProductDetailBasic(id: "12"),
      await getProductDetailBasic(id: "13"),
      await getProductDetailBasic(id: "14"),
      await getProductDetailBasic(id: "15"),
    ];
    return result;
  }

  ///History Search Basic
  static Future<Map<String, dynamic>> getHistorySearchRealEstate() async {
    var result = await UtilAsset.loadJson("assets/data/search_history.json");
    result['data']['history'] = [
      await getProductDetailRealEstate(id: "1"),
      await getProductDetailRealEstate(id: "2"),
      await getProductDetailRealEstate(id: "3"),
      await getProductDetailRealEstate(id: "4"),
      await getProductDetailRealEstate(id: "5"),
      await getProductDetailRealEstate(id: "6"),
      await getProductDetailRealEstate(id: "7"),
      await getProductDetailRealEstate(id: "8"),
    ];
    result['data']['recently'] = [
      await getProductDetailRealEstate(id: "8"),
      await getProductDetailRealEstate(id: "7"),
      await getProductDetailRealEstate(id: "6"),
      await getProductDetailRealEstate(id: "5"),
      await getProductDetailRealEstate(id: "4"),
    ];
    return result;
  }

  ///History Search Basic
  static Future<Map<String, dynamic>> getHistorySearchFood() async {
    var result = await UtilAsset.loadJson("assets/data/search_history.json");
    result['data']['history'] = [
      await getProductDetailFood(id: "1"),
      await getProductDetailFood(id: "2"),
      await getProductDetailFood(id: "3"),
      await getProductDetailFood(id: "4"),
      await getProductDetailFood(id: "5"),
      await getProductDetailFood(id: "6"),
      await getProductDetailFood(id: "7"),
    ];
    result['data']['recently'] = [
      await getProductDetailFood(id: "7"),
      await getProductDetailFood(id: "6"),
      await getProductDetailFood(id: "5"),
      await getProductDetailFood(id: "4"),
    ];
    return result;
  }

  ///History Search Basic
  static Future<Map<String, dynamic>> getHistorySearchEvent() async {
    var result = await UtilAsset.loadJson("assets/data/search_history.json");
    result['data']['history'] = [
      await getProductDetailEvent(id: "1"),
      await getProductDetailEvent(id: "2"),
      await getProductDetailEvent(id: "3"),
      await getProductDetailEvent(id: "4"),
      await getProductDetailEvent(id: "5"),
      await getProductDetailEvent(id: "6"),
      await getProductDetailEvent(id: "7"),
      await getProductDetailEvent(id: "8"),
    ];
    result['data']['recently'] = [
      await getProductDetailEvent(id: "8"),
      await getProductDetailEvent(id: "7"),
      await getProductDetailEvent(id: "6"),
      await getProductDetailEvent(id: "5"),
      await getProductDetailEvent(id: "4"),
    ];
    return result;
  }

  ///WishList Basic
  static Future<Map<String, dynamic>> getWishList() async {
    final userRepository = UserRepository();
    UserModel user = await userRepository.getUser();
    var http = HTTPManager();
    if (user != null) {
      var res = await http.get(url: '$BASE_URL/user/wishlist/${user.id}');
      List<Map> maplist = [];
      if (res['success']) {
        List products = res['data'];
        for (var p in products) {
          Map map = await getProductDetailBasic(id: p['_id']);
          maplist.add(map);
        }
        return {
          "success": true,
          "data": maplist,
          "message": "get data success"
        };
      }
    } else {
      return {"success": false, "data": [], "message": "User not Loged in Nothing to show"};
    }
  }

  ///WishList Real Estate
  static Future<Map<String, dynamic>> getWishListRealEstate() async {
    return {
      "success": true,
      "data": [
        await getProductDetailRealEstate(id: "2"),
        await getProductDetailRealEstate(id: "4"),
        await getProductDetailRealEstate(id: "6"),
        await getProductDetailRealEstate(id: "8"),
      ],
      "message": "get data success"
    };
  }

  ///WishList Event
  static Future<Map<String, dynamic>> getWishListEvent() async {
    return {
      "success": true,
      "data": [
        await getProductDetailEvent(id: "2"),
        await getProductDetailEvent(id: "4"),
        await getProductDetailEvent(id: "6"),
        await getProductDetailEvent(id: "8"),
      ],
      "message": "get data success"
    };
  }

  ///WishList Food
  static Future<Map<String, dynamic>> getWishListFood() async {
    return {
      "success": true,
      "data": [
        await getProductDetailFood(id: "2"),
        await getProductDetailFood(id: "4"),
        await getProductDetailFood(id: "6"),
      ],
      "message": "get data success"
    };
  }

  ///List Product Basic
  static Future<Map<String, dynamic>> getProductBasic() async {
    return {
      "success": true,
      "data": [
        await getProductDetailBasic(id: "1"),
        await getProductDetailBasic(id: "2"),
        await getProductDetailBasic(id: "3"),
        await getProductDetailBasic(id: "4"),
        await getProductDetailBasic(id: "5"),
        await getProductDetailBasic(id: "6"),
        await getProductDetailBasic(id: "7"),
        await getProductDetailBasic(id: "8"),
        await getProductDetailBasic(id: "9"),
        await getProductDetailBasic(id: "10"),
        await getProductDetailBasic(id: "11"),
        await getProductDetailBasic(id: "12"),
        await getProductDetailBasic(id: "13"),
        await getProductDetailBasic(id: "14"),
        await getProductDetailBasic(id: "15"),
      ],
      "message": "get data success"
    };
  }

  ///Get List RealEstate
  static Future<Map<String, dynamic>> getProductRealEstate() async {
    return {
      "success": true,
      "data": [
        await getProductDetailRealEstate(id: "1"),
        await getProductDetailRealEstate(id: "2"),
        await getProductDetailRealEstate(id: "3"),
        await getProductDetailRealEstate(id: "4"),
        await getProductDetailRealEstate(id: "5"),
        await getProductDetailRealEstate(id: "6"),
        await getProductDetailRealEstate(id: "7"),
        await getProductDetailRealEstate(id: "8"),
      ],
      "message": "get data success"
    };
  }

  ///Get List RealEstate
  static Future<Map<String, dynamic>> getProductEvent() async {
    return {
      "success": true,
      "data": [
        await getProductDetailEvent(id: "1"),
        await getProductDetailEvent(id: "2"),
        await getProductDetailEvent(id: "3"),
        await getProductDetailEvent(id: "4"),
        await getProductDetailEvent(id: "5"),
        await getProductDetailEvent(id: "6"),
        await getProductDetailEvent(id: "7"),
        await getProductDetailEvent(id: "8"),
      ],
      "message": "get data success"
    };
  }

  ///Get List RealEstate
  static Future<Map<String, dynamic>> getProductFood() async {
    return {
      "success": true,
      "data": [
        await getProductDetailFood(id: "1"),
        await getProductDetailFood(id: "2"),
        await getProductDetailFood(id: "3"),
        await getProductDetailFood(id: "4"),
        await getProductDetailFood(id: "5"),
        await getProductDetailFood(id: "6"),
        await getProductDetailFood(id: "7"),
      ],
      "message": "get data success"
    };
  }

  ///Singleton factory
  static final UtilData _instance = UtilData._internal();

  factory UtilData() {
    return _instance;
  }

  UtilData._internal();
}
