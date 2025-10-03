import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/diet_plan_details_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/diet_plan_services_provider.dart';
import 'package:get/get.dart';

class DietPlanDetailsBinding extends Bindings {
  final DietPlanEntity dietPlan;
  DietPlanDetailsBinding({required this.dietPlan});
  @override
  void dependencies() {
    final DietPlanServicesProvider provider =
        Get.find<DietPlanServicesProvider>();
    Get.put<DietPlanDetailsController>(
      DietPlanDetailsController(
        getDietPlanMealUseCase: provider.getDietPlanMealUseCase,
        getTotalCaloriesUseCase: provider.getTotalCaloriesUseCase,
        getTotalProteinUseCase: provider.getTotalProteinUseCase,
        getTotalFatUseCase: provider.getTotalFatUseCase,
        getTotalCarbohydrateUseCase: provider.getTotalCarbohydrateUseCase,
        deleteMealUseCase: provider.deleteMealUseCase,
        dietPlan: dietPlan,
      ),
    );
  }
}
