import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/use_cases/theme_use_cases/get_theme_mode_use_case.dart';
import 'package:gaia_nutrition_plans/features/root_feature/domain_layer/use_cases/theme_use_cases/set_theme_mode_use_case.dart';
import 'package:get/get.dart';

class GaiaNutritionPlansAppController extends GetxController {
  final GetThemeModeUseCase getThemeModeUseCase;
  final SetThemeModeUseCase setThemeModeUseCase;

  bool isDarkMode = false;

  GaiaNutritionPlansAppController({
    required this.getThemeModeUseCase,
    required this.setThemeModeUseCase,
  });

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isDarkMode = await getThemeModeUseCase.execute();
    update();
  }

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    update();
    await setThemeModeUseCase.execute(isDarkMode);
  }

  ThemeMode get currentTheme => isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
