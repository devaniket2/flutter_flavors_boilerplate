import 'package:flutter_flavors_boilerplate/core/services/shared_preference_service.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/models/auth_user_model.dart';
import 'package:flutter_flavors_boilerplate/utils/logger/app_logger.dart';

abstract class AuthLocalDataSource {
  Future<AuthUserModel?> get user;
  Future<bool> get isLoggedin;
  Future<String?> get authToken;
  Future<bool> saveAuth(AuthUserModel user);
  Future<bool> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<String?> get authToken =>
      SharedPrefernceService.getString(SharedPrefernceKeys.AUTH_TOKEN);

  @override
  Future<bool> clearAuth() async {
    try {
      await SharedPrefernceService.remove(SharedPrefernceKeys.AUTH_TOKEN);
      await SharedPrefernceService.remove(SharedPrefernceKeys.USER);
      return true;
    } catch (err) {
      logError(
        'Error occured when removing auth values : ${err.toString()}',
        tag: 'AuthLocalDataSource',
      );
      return false;
    }
  }

  @override
  Future<bool> get isLoggedin async =>
      await SharedPrefernceService.getString(SharedPrefernceKeys.AUTH_TOKEN) !=
          null &&
      await SharedPrefernceService.getObject(
            SharedPrefernceKeys.USER,
            (json) => AuthUserModel.fromJson(json),
          ) !=
          null;

  @override
  Future<AuthUserModel?> get user =>
      SharedPrefernceService.getObject<AuthUserModel>(
        SharedPrefernceKeys.USER,
        (json) => AuthUserModel.fromJson(json),
      );

  @override
  Future<bool> saveAuth(AuthUserModel user) async {
    try {
      if (user.token == null) return false;

      // user
      await SharedPrefernceService.saveObject(
        SharedPrefernceKeys.USER,
        user.toJson(),
      );
      //token
      await SharedPrefernceService.saveString(
        SharedPrefernceKeys.AUTH_TOKEN,
        user.token!,
      );
      return true;
    } catch (error) {
      logError('error saving mock user: ${error.toString()}');
      return false;
    }
  }
}
