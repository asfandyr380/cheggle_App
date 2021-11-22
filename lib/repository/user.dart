import 'dart:convert';

import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class UserRepository {
  final application = Application();

  ///Fetch api login
  Future<UserModel> login({
    String username,
    String password,
  }) async {
    ///Fetch API
    final result = await Api.login(
      username: username,
      password: password,
    );

    ///Case API fail but not have token
    if (result.success) {
      ///Login API success
      return UserModel.fromJson(result.data);
    }

    return null;
  }

  ///Fetch api validToken
  Future<dynamic> validateToken() async {
    final result = await Api.validateToken();

    ///Fetch api success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }
    return null;
  }

  Future<void> saveUser({UserModel user}) async {
    await application.setUser(user);
    await UtilPreferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  Future<UserModel> getUser() async {
    final getUserPreferences = UtilPreferences.getString(Preferences.user);
    if (getUserPreferences != null) {
      return UserModel.fromJson(jsonDecode(getUserPreferences));
    }
    return null;
  }

  Future<void> deleteUser({UserModel user}) async {
    await application.setUser(null);
    await UtilPreferences.remove(Preferences.user);
  }

  ///Singleton factory
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
}
