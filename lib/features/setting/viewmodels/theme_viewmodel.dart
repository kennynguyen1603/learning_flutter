import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:learning_flutter/core/constants/constants.dart';
import 'package:learning_flutter/core/providers/shared_prefs_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(SharedPrefsService.isDarkMode);

  void toggleTheme() async {
    state = !state;
    await SharedPrefsService.setIsDarkMode(state);
  }

  Future<void> loadTheme() async {
    state = SharedPrefsService.isDarkMode;
  }
}
