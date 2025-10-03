import 'package:gaia_nutrition_plans/features/root_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/theme_abstract_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/repositories_interfaces/theme_repository_interface.dart';

class ThemeRepositoryImplemntation implements ThemeRepositoryInterface {
  final ThemeAbstractLocalDataSource themeAbstractLocalDataSource;
  ThemeRepositoryImplemntation({required this.themeAbstractLocalDataSource});

  @override
  Future<bool> getThemeMode() async {
    return await themeAbstractLocalDataSource.getThemeMode();
  }

  @override
  Future<void> setThemeMode(bool isDarkMode) async {
    await themeAbstractLocalDataSource.setThemeMode(isDarkMode);
  }
}
