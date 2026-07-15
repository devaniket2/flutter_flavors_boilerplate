import 'package:flutter_flavors_boilerplate/core/network/api_service.dart';

abstract class AuthRemoteDataSource {}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);
}
