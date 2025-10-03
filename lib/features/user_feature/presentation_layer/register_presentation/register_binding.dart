import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    final UserServicesProvider userServicesProvider =
        Get.find<UserServicesProvider>();
    Get.lazyPut<RegisterController>(
      () => RegisterController(userServicesProvider.registerUseCase),
    );
  }
}
