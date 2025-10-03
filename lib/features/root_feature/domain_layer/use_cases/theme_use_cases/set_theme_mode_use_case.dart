import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/repositories_interfaces/theme_repository_interface.dart';

class SetThemeModeUseCase {
  final ThemeRepositoryInterface themeRepositoryInterface;

  SetThemeModeUseCase({required this.themeRepositoryInterface});

  Future<void> execute(bool isDarkMode) async {
    await themeRepositoryInterface.setThemeMode(isDarkMode);
  }
}
