import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GoalService {
  static const String _goalsKey = 'goals_list';

  // POST /goal/add
  static Future<Map<String, dynamic>> addGoal({
    required String userId,
    required String title,
    String? deadlineIso,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final createdAt = DateTime.now().toIso8601String();
    final goal = {
      'id': id,
      'user_id': userId,
      'title': title,
      'deadline': deadlineIso,
      'status': 'pending',
      'created_at': createdAt,
    };

    final listStr = prefs.getString(_goalsKey);
    final List<dynamic> list = listStr == null ? [] : jsonDecode(listStr);
    list.add(goal);
    await prefs.setString(_goalsKey, jsonEncode(list));
    return goal as Map<String, dynamic>;
  }

  // GET /goal/list
  static Future<List<Map<String, dynamic>>> listGoals({
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final listStr = prefs.getString(_goalsKey);
    final List<dynamic> list = listStr == null ? [] : jsonDecode(listStr);
    return list
        .whereType<Map<String, dynamic>>()
        .where((g) => g['user_id'] == userId)
        .toList();
  }

  static Future<void> setCompleted({
    required String goalId,
    required bool completed,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final listStr = prefs.getString(_goalsKey);
    final List<dynamic> list = listStr == null ? [] : jsonDecode(listStr);
    for (int i = 0; i < list.length; i++) {
      final g = list[i] as Map<String, dynamic>;
      if (g['id'] == goalId) {
        g['status'] = completed ? 'completed' : 'pending';
        list[i] = g;
        break;
      }
    }
    await prefs.setString(_goalsKey, jsonEncode(list));
  }
}



