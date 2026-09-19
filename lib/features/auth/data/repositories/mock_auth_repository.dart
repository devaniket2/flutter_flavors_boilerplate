import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_flavors_boilerplate/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/models/auth_user_model.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  MockAuthRepository({required this.localDataSource});

  @override
  Future<AuthUserModel?> login(String email, String password) async {
    await Future.delayed(2.seconds);

    final userData = {
      "id": "usr_90a21f8e7c",
      "token": "ey_asdjaksjduew8r32432ijh3h9843vu538454",
      "first_name": "Aniket",
      "last_name": "Nandi",
      "email": "aniket.dev.ind@gmail.com",
      "avatar_url": "https://api.dicebear.com/7.x/adventurer/svg?seed=Alex",
      "role": "Software Engineer and Architecture",
      "is_active": true,
      "joined_at": "2026-03-15T08:30:00Z",
      "last_login": "2026-07-15T02:45:12Z",
    };

    AuthUserModel user = AuthUserModel.fromJson(userData);

    if (email == user.email && password == '123456') {
      // save to local
      await localDataSource.saveAuth(user);
      return user;
    } else {
      throw Exception('Incorrect email or password');
    }
  }

  @override
  Future<bool> logout() async {
    await Future.delayed(2.seconds);

    return await localDataSource.clearAuth();
  }

  @override
  Future<bool> get isLoggedin => localDataSource.isLoggedin;
}
