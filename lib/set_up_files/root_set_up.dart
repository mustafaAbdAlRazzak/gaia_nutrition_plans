import 'package:gaia_nutrition_plans/features/root_feature/presentation_layer/gaia_nutrition_plans_app_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/root_services_provider.dart';
import 'package:get/get.dart';

Future<void> rootSetUp() async {
  final RootServicesProvider rootServices = await Get.putAsync(
    () => RootServicesProvider().init(),
  );
  Get.put<GaiaNutritionPlansAppController>(
    GaiaNutritionPlansAppController(
      getThemeModeUseCase: rootServices.getThemeModeUseCase,
      setThemeModeUseCase: rootServices.setThemeModeUseCase,
    ),
  );
}
