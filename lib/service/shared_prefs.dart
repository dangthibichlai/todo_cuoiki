import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String accessTokenKey = 'accessToken';
  static const String userIdKey = 'userId';

  static late SharedPreferences _prefs;

  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get token {
    return _prefs.getString(accessTokenKey);
  }

  static String? get userId {
    return _prefs.getString(userIdKey);
  }

  static set token(String? token) => _prefs.setString(accessTokenKey, token ?? '');

  static set userId(String? userId) => _prefs.setString(userIdKey, userId ?? '');

  static bool get isLogin => token?.isNotEmpty ?? false;

  static removeSeason() {
    _prefs.remove(accessTokenKey);
  }
}
