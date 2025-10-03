import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    final UserServicesProvider userServicesProvider =
        Get.find<UserServicesProvider>();
    Get.lazyPut<LoginController>(
      () => LoginController(userServicesProvider.loginUseCase),
    );
  }
}
