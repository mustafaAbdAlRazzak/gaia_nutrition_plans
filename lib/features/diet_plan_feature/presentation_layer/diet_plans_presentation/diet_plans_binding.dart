import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plans_presentation/diet_plans_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/diet_plan_services_provider.dart';
import 'package:get/get.dart';

class DietPlansBinding extends Bindings {
  @override
  void dependencies() {
    final DietPlanServicesProvider dietPlanServices =
        Get.find<DietPlanServicesProvider>();
    Get.put<DietPlansController>(
      DietPlansController(
        getDietPlansUseCase: dietPlanServices.getDietPlansUseCase,
        deleteDietPlanUseCase: dietPlanServices.deleteDietPlanUseCase,
      ),
    );
  }
}
