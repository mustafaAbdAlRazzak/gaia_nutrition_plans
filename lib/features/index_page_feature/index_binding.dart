import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plans_presentation/diet_plans_binding.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_binding.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_controller.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/profile_presentation/profile_binding.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    FoodsListBinding().dependencies();
    DietPlansBinding().dependencies();
    ProfileBinding().dependencies();
    final UserServicesProvider userServicesProvider =
        Get.find<UserServicesProvider>();
    Get.put<IndexController>(
      IndexController(
        getCurrentUserUseCase:
            userServicesProvider.getCurrentUserProfileUseCase,
      ),
    );
  }
}
