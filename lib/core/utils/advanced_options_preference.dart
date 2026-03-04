import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvancedOptionsState {
  final bool antialiasing;
  final bool smoothing;

  const AdvancedOptionsState({
    required this.antialiasing,
    required this.smoothing,
  });

  AdvancedOptionsState copyWith({
    bool? antialiasing,
    bool? smoothing,
  }) {
    return AdvancedOptionsState(
      antialiasing: antialiasing ?? this.antialiasing,
      smoothing: smoothing ?? this.smoothing,
    );
  }
}

class AdvancedOptionsNotifier
    extends StateNotifier<AdvancedOptionsState> {
  static const _antialiasKey = 'advanced_antialias';
  static const _smoothingKey = 'advanced_smoothing';

  AdvancedOptionsNotifier()
      : super(const AdvancedOptionsState(
    antialiasing: false,
    smoothing: false,
  )) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = AdvancedOptionsState(
      antialiasing: prefs.getBool(_antialiasKey) ?? false,
      smoothing: prefs.getBool(_smoothingKey) ?? false,
    );
  }

  Future<void> setAntialiasing(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_antialiasKey, value);
    state = state.copyWith(antialiasing: value);
  }

  Future<void> setSmoothing(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_smoothingKey, value);
    state = state.copyWith(smoothing: value);
  }
}

final advancedOptionsProvider =
StateNotifierProvider<AdvancedOptionsNotifier,
    AdvancedOptionsState>(
      (ref) => AdvancedOptionsNotifier(),
);