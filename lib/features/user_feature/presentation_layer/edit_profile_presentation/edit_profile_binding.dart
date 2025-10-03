import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    final UserServicesProvider userServicesProvider =
        Get.find<UserServicesProvider>();
    // Register the EditProfileController
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        updateProfileUseCase: userServicesProvider.updateProfileUseCase,
        getCurrentUserUseCase:
            userServicesProvider.getCurrentUserProfileUseCase,
      ),
    );
  }
}
