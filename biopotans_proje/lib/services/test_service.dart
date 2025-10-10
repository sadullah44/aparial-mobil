import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TestService {
  static const String _testKey = 'test_results';

  // POST /test/submit
  static Future<Map<String, dynamic>> submit({
    required String userId,
    required int score,
    required String recommendation,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final createdAt = DateTime.now().toIso8601String();
    final result = {
      'id': id,
      'user_id': userId,
      'score': score,
      'recommendation': recommendation,
      'created_at': createdAt,
    };

    final listStr = prefs.getString(_testKey);
    final List<dynamic> list = listStr == null ? [] : jsonDecode(listStr);
    list.add(result);
    await prefs.setString(_testKey, jsonEncode(list));
    return result as Map<String, dynamic>;
  }
}



