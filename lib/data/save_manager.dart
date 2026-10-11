import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  static Future<Map<int, int>> getStars() async {
    final p = await SharedPreferences.getInstance();
    final map = <int, int>{};
    for (int i = 1; i <= 30; i++) {
      map[i] = p.getInt('stars_$i') ?? 0;
    }
    return map;
  }

  static Future<int> getStarsFor(int stageId) async {
    final p = await SharedPreferences.getInstance();
    return p.getInt('stars_$stageId') ?? 0;
  }

  static Future<void> setStars(int stageId, int stars) async {
    final p = await SharedPreferences.getInstance();
    final current = p.getInt('stars_$stageId') ?? 0;
    if (stars > current) {
      await p.setInt('stars_$stageId', stars);
    }
  }

  static Future<bool> isUnlocked(int stageId) async {
    if (stageId == 1) return true;
    final p = await SharedPreferences.getInstance();
    return p.getBool('unlocked_$stageId') ?? false;
  }

  static Future<void> unlock(int stageId) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('unlocked_$stageId', true);
  }

  static Future<int> getCurrentStage() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt('current_stage') ?? 1;
  }

  static Future<void> setCurrentStage(int stageId) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('current_stage', stageId);
  }

  static Future<int> getTotalStars() async {
    final stars = await getStars();
    return stars.values.fold<int>(0, (a, b) => a + b);
  }

  static Future<void> resetAll() async {
    final p = await SharedPreferences.getInstance();
    for (int i = 1; i <= 30; i++) {
      await p.remove('stars_$i');
      await p.remove('unlocked_$i');
    }
    await p.remove('current_stage');
  }
}