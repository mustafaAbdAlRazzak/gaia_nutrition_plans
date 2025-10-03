import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/auth_gate_presentation/auth_gate_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class AuthGateBinding extends Bindings {
  @override
  void dependencies() {
    final UserServicesProvider userServicesProvider =
        Get.find<UserServicesProvider>();
    Get.put<AuthGateController>(
      AuthGateController(userServicesProvider.isUserLoggedInUseCase),
    );
  }
}
