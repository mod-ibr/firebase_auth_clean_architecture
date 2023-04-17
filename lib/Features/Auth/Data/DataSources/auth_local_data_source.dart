import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Errors/exception.dart';
import '../../../../core/Utils/Constants/auth_constants.dart';
import '../Models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<AuthModel> getUserData();
  Future<Unit> setUserData(AuthModel authModel);
  Future<Unit> clearUserData();
  Future<Unit> setIsUserLoggedIn({required bool isUserLoggedIn});
  Future<bool?> getIsUserLoggedIn();
}

class AuthLocalDataSourceSharedPrefes implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceSharedPrefes(this.sharedPreferences);

  @override
  Future<Unit> setUserData(AuthModel authModel) async {
    Map<String, dynamic> authModelToJson = authModel.toJson();

    await sharedPreferences.setString(
        AuthConstants.kUserData, json.encode(authModelToJson));
    await sharedPreferences.setBool(AuthConstants.kIsUserLoggedIn, true);
    return Future.value(unit);
  }

  @override
  Future<AuthModel> getUserData() async {
    final jsonString = sharedPreferences.getString(AuthConstants.kUserData);
    if (jsonString != null) {
      Map<String, dynamic> jsonToAuthModel =
          json.decode(jsonString) as Map<String, dynamic>;

      AuthModel savedModel = AuthModel.fromJson(jsonToAuthModel);

      return savedModel;
    } else {
      throw NoSavedUserException();
    }
  }

  @override
  Future<Unit> clearUserData() async {
    await sharedPreferences.clear();
    return Future.value(unit);
  }

  @override
  Future<Unit> setIsUserLoggedIn({required bool isUserLoggedIn}) async {
    await sharedPreferences.setBool(
        AuthConstants.kIsUserLoggedIn, isUserLoggedIn);
    return Future.value(unit);
  }

  @override
  Future<bool?> getIsUserLoggedIn() async {
    final isUserLoggedIn =
        sharedPreferences.getBool(AuthConstants.kIsUserLoggedIn);
    return isUserLoggedIn;
  }
}
