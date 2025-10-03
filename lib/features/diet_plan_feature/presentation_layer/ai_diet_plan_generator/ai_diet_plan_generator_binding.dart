import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_controller.dart';
import 'package:get/get.dart';

class AiDietPlanGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiDietPlanGeneratorController>(
      () => AiDietPlanGeneratorController(),
    );
  }
}
