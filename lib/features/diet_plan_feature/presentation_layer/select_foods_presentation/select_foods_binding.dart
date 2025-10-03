import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/select_foods_presentation/select_foods_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/food_services_provider.dart';
import 'package:get/get.dart';

class SelectFoodsBinding extends Bindings {
  @override
  void dependencies() {
    final FoodServicesProvider foodServicesProvider =
        Get.find<FoodServicesProvider>();
    Get.put(
      SelectFoodsController(
        getFoodsUseCase: foodServicesProvider.getFoodsUseCase,
      ),
    );
  }
}
