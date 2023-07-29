import 'package:dogs_and_cats/src/utils/shared_preference.dart';

class StorageController extends SharedPreference {
  static StorageController? _instance;

  factory StorageController() => _instance ??= StorageController._();

  StorageController._();

  String? _token;
  String? _userID;

  Future<void> init() async {
    await Future.wait([
      loadToken().then((value) => _token = value),
      loadUserID().then((value) => _userID = value),
    ]);
  }

  /// Token
  String get token => _token!;

  bool get hasToken => _token != null;

  void get deleteToken => _token = null;

  set token(String? value) {
    _token = value;
    if (value == null) {
      clearToken();
    } else {
      saveToken(value);
    }
  }

  /// userID
  String? get userID => _userID;

  bool get hasUserID => _userID != null;

  set userID(String? id) {
    _userID = id;
    if (id == null) {
      clearUserID();
    } else {
      saveUserID(id);
    }
  }
}
