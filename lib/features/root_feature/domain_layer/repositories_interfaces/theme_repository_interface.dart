abstract class ThemeRepositoryInterface {
  Future<void> setThemeMode(bool isDarkMode);
  Future<bool> getThemeMode();
}
