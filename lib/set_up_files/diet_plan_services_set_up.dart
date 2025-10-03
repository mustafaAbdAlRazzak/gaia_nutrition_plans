import 'package:gaia_nutrition_plans/services_providers/diet_plan_services_provider.dart';
import 'package:get/get.dart';

Future<void> dietPlanServicesSetUp() async {
  await Get.putAsync<DietPlanServicesProvider>(
    () => DietPlanServicesProvider().init(),
  );
}
