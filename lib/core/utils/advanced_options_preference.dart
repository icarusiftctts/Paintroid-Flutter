import 'package:shared_preferences/shared_preferences.dart';

class AdvancedOptionsService {
  static const _antialiasKey = 'advanced_antialias';
  static const _smoothingKey = 'advanced_smoothing';

  Future<bool> getAntialiasing() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_antialiasKey) ?? false;
  }

  Future<bool> getSmoothing() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_smoothingKey) ?? false;
  }

  Future<void> setAntialiasing(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_antialiasKey, value);
  }

  Future<void> setSmoothing(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_smoothingKey, value);
  }
}