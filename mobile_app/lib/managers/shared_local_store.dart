import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStore {
  static const _keySessionId = 'session_id';

  static Future<void> setSessionId(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySessionId, sessionId);
  }

  static Future<int> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keySessionId) ?? -1;
  }
}
