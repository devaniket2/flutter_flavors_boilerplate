// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceKeys {
  SharedPrefernceKeys._();

  // keys
  static const IS_FIRST_LAUNCH = 'first_launch';
  static const AUTH_TOKEN = 'auth_token';
  static const USER = 'user';
  static const APP_PAUSED_TIME = 'app_pause_on';
}

class SharedPrefernceService {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> get preferences async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  // Save a String value
  static Future<bool> saveString(String key, String value) async {
    final prefs = await preferences;
    return prefs.setString(key, value);
  }

  // Retrieve a String value
  static Future<String> getString(
    String key, {
    String defaultValue = '',
  }) async {
    final prefs = await preferences;
    final value = prefs.getString(key);
    return value ?? defaultValue;
  }

  // Save an Object value (converted to JSON string)
  static Future<bool> saveObject(String key, dynamic value) async {
    final prefs = await preferences;
    // Convert value to JSON and save it as a string
    final jsonString = json.encode(value);
    return prefs.setString(key, jsonString);
  }

  static Future<T?> getObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final prefs = await preferences;
    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    }
    return null;
  }

  // Save a Boolean value
  static Future<bool> saveBoolean(String key, bool value) async {
    final prefs = await preferences;
    return prefs.setBool(key, value);
  }

  // Retrieve a Boolean value
  static Future<bool> getBoolean(
    String key, {
    bool defaultValue = false,
  }) async {
    final prefs = await preferences;
    final value = prefs.getBool(key);
    return value ?? defaultValue;
  }

  // Save a numeric value
  static Future<bool> saveNumber(String key, num value) async {
    final prefs = await preferences;
    return prefs.setDouble(key, value.toDouble());
  }

  // Retrieve a numeric value
  static Future<num> getNumber(String key, {int defaultValue = 0}) async {
    final prefs = await preferences;
    final doubleValue = prefs.getDouble(key);
    return doubleValue ?? defaultValue;
  }

  // Remove a specific preference value
  static Future<bool> remove(String key) async {
    final prefs = await preferences;
    return prefs.remove(key);
  }

  // Clear all preference values
  static Future<bool> clear() async {
    final prefs = await preferences;
    return prefs.clear();
  }

  // storing and accessing the FIRST_LAUNCH by null safe methods
  // by not changing alreday implemented access valu methods as
  // it could break a lot of feature

  /// These functions are only meant to use for storing ang retrieving
  /// `IS_FIRST_LAUNCH` value which denotes whether it is the first
  /// time of opening the app after installation or not

  /// stores `IS_FIRST_LAUNCH` into `SharedPreferences`
  static Future<void> setFirstLaunchBoolean(bool val) async {
    preferences.then(
      (prefs) => prefs.setBool(SharedPrefernceKeys.IS_FIRST_LAUNCH, val),
    );
  }

  /// retrieves `IS_FIRST_LAUNCH` from `SharedPreferences`
  static Future<bool?> getFirstLaunchBoolean() async {
    return preferences.then(
      (prefs) => prefs.getBool(SharedPrefernceKeys.IS_FIRST_LAUNCH),
    );
  }
}
