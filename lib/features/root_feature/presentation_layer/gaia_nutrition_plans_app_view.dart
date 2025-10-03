import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/root_feature/presentation_layer/gaia_nutrition_plans_app_controller.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/auth_gate_presentation/auth_gate_binding.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/auth_gate_presentation/auth_gate_page.dart';
import 'package:get/get.dart';

class GaiaNutritionPlansApp extends StatelessWidget {
  const GaiaNutritionPlansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GaiaNutritionPlansAppController>(
      builder: (controller) {
        return GetMaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: controller.currentTheme,
          initialBinding: AuthGateBinding(),
          home: const AuthGatePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
