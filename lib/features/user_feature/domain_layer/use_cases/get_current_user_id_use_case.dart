import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/repositories_interfaces/user_repository_interface.dart';

class GetCurrentUserIdUseCase {
  final UserRepositoryInterface userRepositoryInterface;

  GetCurrentUserIdUseCase(this.userRepositoryInterface);

  String execute() {
    return userRepositoryInterface.getCurrentUserId();
  }
}
