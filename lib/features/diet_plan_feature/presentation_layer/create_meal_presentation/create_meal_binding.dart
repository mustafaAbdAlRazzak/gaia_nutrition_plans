import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/diet_plan_services_provider.dart';
import 'package:gaia_nutrition_plans/services_providers/food_services_provider.dart';
import 'package:get/get.dart';

class CreateMealBinding extends Bindings {
  final int dietPlanId;
  final MealEntity? meal;
  CreateMealBinding({required this.dietPlanId, this.meal});

  @override
  void dependencies() {
    final DietPlanServicesProvider dietPlanServicesProvider =
        Get.find<DietPlanServicesProvider>();
    final FoodServicesProvider foodServicesProvider =
        Get.find<FoodServicesProvider>();
    Get.lazyPut<CreateMealController>(
      () => CreateMealController(
        createMealIngredientUseCase:
            dietPlanServicesProvider.createMealIngredientUseCase,
        createMealUseCase: dietPlanServicesProvider.createMealUseCase,
        saveFoodUseCase: foodServicesProvider.saveFoodUseCase,
        dietPlanId: dietPlanId,
        getMealIngredientsUseCase:
            dietPlanServicesProvider.getMealIngredientsUseCase,
        getFoodFormLocalDataBaseByIdUseCase:
            foodServicesProvider.getFoodFormLocalDataBaseByIdUseCase,
        deleteMealIngredientUseCase:
            dietPlanServicesProvider.deleteMealIngredientUseCase,
        updateMealIngredientUseCase:
            dietPlanServicesProvider.updateMealIngredientUseCase,
        updateMealUseCase: dietPlanServicesProvider.updateMealUseCase,
        meal: meal,
      ),
    );
  }
}
