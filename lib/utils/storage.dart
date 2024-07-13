import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static late SharedPreferences _prefs;

  StorageUtil._();

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static String? getString(String key) {
    String? value = _prefs.getString(key);
    return value;
  }

  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    bool? value = _prefs.getBool(key);
    return value;
  }

  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    int? value = _prefs.getInt(key);
    return value;
  }

  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  static List<String>? getStringList(String key) {
    List<String>? value = _prefs.getStringList(key);
    return value;
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  static List<int>? getIntList(String key) {
    List<int>? value =
        _prefs.getStringList(key)?.map((e) => int.parse(e)).toList();
    return value;
  }

  static Future<bool> setIntList(String key, List<int> value) {
    List<String> valueList = value.map((e) => e.toString()).toList();
    return _prefs.setStringList(key, valueList);
  }
}
