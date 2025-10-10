import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MeditationService {
  static const String _sessionKey = 'meditation_sessions';
  static const String _activeKey = 'meditation_active';

  // POST /meditation/start
  static Future<Map<String, dynamic>> start({
    required String userId,
    required int duration,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final start = DateTime.now().toIso8601String();
    await prefs.setString(
      _activeKey,
      jsonEncode({
        'user_id': userId,
        'duration': duration,
        'started_at': start,
      }),
    );
    return {'user_id': userId, 'duration': duration, 'started_at': start};
  }

  // POST /meditation/finish
  static Future<Map<String, dynamic>> finish({required String userId}) async {
    final prefs = await SharedPreferences.getInstance();
    final activeStr = prefs.getString(_activeKey);
    if (activeStr == null) {
      throw Exception('Aktif meditasyon bulunamadı');
    }
    final active = jsonDecode(activeStr) as Map<String, dynamic>;
    final duration = active['duration'] as int;
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final completedAt = DateTime.now().toIso8601String();
    final session = {
      'id': id,
      'user_id': userId,
      'duration': duration,
      'completed_at': completedAt,
    };
    final listStr = prefs.getString(_sessionKey);
    final List<dynamic> list = listStr == null ? [] : jsonDecode(listStr);
    list.add(session);
    await prefs.setString(_sessionKey, jsonEncode(list));
    await prefs.remove(_activeKey);
    return session as Map<String, dynamic>;
  }
}



