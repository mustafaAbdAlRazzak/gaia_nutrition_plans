import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/profile_presentation/profile_controller.dart';
import 'package:gaia_nutrition_plans/services_providers/user_services_provider.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final UserServicesProvider userServicesProvider =
        Get.find<UserServicesProvider>();
    Get.put<ProfileController>(
      ProfileController(
        changePasswordUseCase: userServicesProvider.changePasswordUseCase,
        deleteAccountUseCase: userServicesProvider.deleteAccountUseCase,
        getCurrentUserUseCase:
            userServicesProvider.getCurrentUserProfileUseCase,
        logoutUseCase: userServicesProvider.logoutUseCase,
        getClientSecretUseCase: userServicesProvider.getClientSecretUseCase,
        isUserSubscribedUseCase: userServicesProvider.isUserSubscribedUseCase,
      ),
    );
  }
}
