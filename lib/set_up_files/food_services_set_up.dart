import 'package:gaia_nutrition_plans/services_providers/food_services_provider.dart';
import 'package:get/get.dart';

Future<void> foodServicesSetUp() async {
  await Get.putAsync<FoodServicesProvider>(() => FoodServicesProvider().init());
}
