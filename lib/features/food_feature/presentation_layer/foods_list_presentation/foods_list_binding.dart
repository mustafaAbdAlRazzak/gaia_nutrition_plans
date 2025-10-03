import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/food_services_provider.dart';
import 'package:get/get.dart';

class FoodsListBinding extends Bindings {
  @override
  void dependencies() {
    final FoodServicesProvider foodServicesProvider =
        Get.find<FoodServicesProvider>();
    Get.put<FoodsListController>(
      FoodsListController(
        getFoodsUseCase: foodServicesProvider.getFoodsUseCase,
        getSavedFoodsUseCase: foodServicesProvider.getSavedFoodsUseCase,
        isFoodSavedUseCase: foodServicesProvider.isFoodSavedUseCase,
        saveFoodUseCase: foodServicesProvider.saveFoodUseCase,
        unsaveFoodUseCase: foodServicesProvider.unsaveFoodUseCase,
      ),
    );
  }
}
