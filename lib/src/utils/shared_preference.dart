import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreference {
  static const String tokenKey = 'token';
  static const String userIDKey = 'userID';

  Future<bool> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(tokenKey, token);
  }

  Future<String?> loadToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(tokenKey);
  }

  Future<bool> clearToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(tokenKey);
  }

  Future<bool> saveUserID(String userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userIDKey, userID);
  }

  Future<String?> loadUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? subjectID = preferences.getString(userIDKey);
    return subjectID;
  }

  Future<bool> clearUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(tokenKey);
  }
}
