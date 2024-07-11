import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thozhil_flutter_app/model/user.model.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  // Keys
  static const String _keyLoggedIn = 'login';
  static const String _keyFilters = 'filters';
  static const String _keyToken = 'token';
  static const String _keyApplApplied = 'applied';
  static const String _keyApplApproved = 'approved';
  static const String _keyApplRejected = 'rejected';
  static const String _keyApplPending = 'pending';

  // Initialize SharedPreferences
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static SharedPreferences getInstance() => _preferences;

  // Set functions
  static Future setLoggedIn(bool loggedIn) async => await _preferences.setBool(_keyLoggedIn, loggedIn);
  static Future setFilters(List<String> filters) async => await _preferences.setStringList(_keyFilters, filters);
  static Future setToken(String token) async => await _preferences.setString(_keyToken, token);

  static Future setApplied(int value) async => await _preferences.setInt(_keyApplApplied, value);
  static Future setApproved(int value) async => await _preferences.setInt(_keyApplApproved, value);
  static Future setRejected(int value) async => await _preferences.setInt(_keyApplRejected, value);
  static Future setPending(int value) async => await _preferences.setInt(_keyApplPending, value);

  static Future setUser(dynamic userJson) async {
    User user = User.fromJson(userJson);

    await _preferences.setString('user', jsonEncode(user.toJson()));
    print('user data saved');
  }

  // Get functions
  static bool getLoggedIn() => _preferences.getBool(_keyLoggedIn) ?? false;
  static List<String> getFilters() => _preferences.getStringList(_keyFilters) ?? ["", "", "", ""];
  static String getToken() => _preferences.getString(_keyToken) ?? '';

  static int getApplied() => _preferences.getInt(_keyApplApplied) ?? 0;
  static int getApproved() => _preferences.getInt(_keyApplApproved) ?? 0;
  static int getRejected() => _preferences.getInt(_keyApplRejected) ?? 0;
  static int getPending() => _preferences.getInt(_keyApplPending) ?? 0;

  static User? getUser() {
    if (_preferences.getString('user') == null) {
      return null;
    } else {
      return User.fromJson(jsonDecode(_preferences.getString('user') ?? ""));
    }
  }

}
