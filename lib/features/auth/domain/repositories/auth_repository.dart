import 'package:flutter_flavors_boilerplate/features/auth/domain/models/auth_user_model.dart';

abstract class AuthRepository {
  Future<bool> get isLoggedin;
  Future<AuthUserModel?> login(String email, String password);
  Future<bool> logout();
}
