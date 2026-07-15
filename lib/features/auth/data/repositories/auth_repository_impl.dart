import 'package:flutter_flavors_boilerplate/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_flavors_boilerplate/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/models/auth_user_model.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthUserModel?> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  // TODO: implement isLoggedin
  Future<bool> get isLoggedin => throw UnimplementedError();
}
