import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/diet_plan_services_provider.dart';
import 'package:get/get.dart';

class SaveDietPlanBinding extends Bindings {
  final DietPlanEntity? dietPlanEntity;
  SaveDietPlanBinding({this.dietPlanEntity});
  @override
  void dependencies() {
    final DietPlanServicesProvider provider =
        Get.find<DietPlanServicesProvider>();
    Get.put<SaveDietPlanController>(
      SaveDietPlanController(
        createDietPlanUseCase: provider.createDietPlanUseCase,
        updateDietPlanUseCase: provider.updateDietPlanUseCase,
        currentDietPlan: dietPlanEntity,
      ),
    );
  }
}
