import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/root_feature/presentation_layer/gaia_nutrition_plans_app_view.dart';
import 'package:gaia_nutrition_plans/set_up_files/app_set_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appSetUp();
  runApp(const GaiaNutritionPlansApp());
}
