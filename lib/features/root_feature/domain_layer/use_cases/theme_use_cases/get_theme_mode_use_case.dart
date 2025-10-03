import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/repositories_interfaces/theme_repository_interface.dart';

class GetThemeModeUseCase {
  final ThemeRepositoryInterface themeRepositoryInterface;

  GetThemeModeUseCase({required this.themeRepositoryInterface});

  Future<bool> execute() async {
    return await themeRepositoryInterface.getThemeMode();
  }
}
