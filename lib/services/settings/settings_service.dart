import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final _instance = SettingsService._internal();

  String _joinEmailKey = 'join:email';
  String _joinPasswordKey = 'join:password';
  String _joinConfirmedKey = 'join:confirmed';

  String _forgotEmailKey = 'forgot:email';

  SettingsService._internal();

  /* forgot */

  Future<bool> setForgotEmail(String email) async {
    return await setString(_forgotEmailKey, email);
  }

  Future<String> getForgotEmail() async {
    return await getString(_forgotEmailKey);
  }

  Future<bool> removeForgotEmail() async {
    return await remove(_forgotEmailKey);
  }

  /* ~forgot */

  /* joined */

  Future<void> setJoined(String email) async {
    await setJoinedConfirmed(false);
    await setJoinedPassword(false);
    await setJoinedEmail(email);
  }

  Future<bool> setJoinedConfirmed(bool confirmed) async {
    return await setBool(_joinConfirmedKey, confirmed);
  }

  Future<bool> getJoinedConfirmed() async {
    return await getBool(_joinConfirmedKey);
  }

  Future<bool> setJoinedPassword(bool updated) async {
    return await setBool(_joinPasswordKey, updated);
  }

  Future<bool> getJoinedPassword() async {
    return await getBool(_joinPasswordKey) || false;
  }

  Future<bool> setJoinedEmail(String email) async {
    return await setString(_joinEmailKey, email);
  }

  Future<String> getJoinedEmail() async {
    return await getString(_joinEmailKey);
  }

  Future<void> removeJoined() async {
    await remove(_joinConfirmedKey);
    await remove(_joinPasswordKey);
    await remove(_joinEmailKey);
  }

  /* ~joined */

  Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? null;
  }

  Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? -1;
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<bool> clear(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static SettingsService getInstance() {
    return _instance;
  }
}
